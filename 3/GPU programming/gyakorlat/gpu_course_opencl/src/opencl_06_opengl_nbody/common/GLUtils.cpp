#include "GLUtils.hpp"

#include <stdio.h>
#include <string>
#include <iostream>
#include <fstream>

#include <SDL3_image/SDL_image.h>

/* 

:H: Az http://www.opengl-tutorial.org/ oldal alapján.
:E: Based on http://www.opengl-tutorial.org/

*/

static void loadShaderCode( std::string& shaderCode, const std::filesystem::path& _fileName )
{
	//:H: shaderkód betöltése _fileName fájlból :E: loading in shader code from the _fileName file
	shaderCode = "";

	//:H: _fileName megnyitása :E: opening _fileName
	std::ifstream shaderStream( _fileName );
#ifdef ELTE_DEV_ONLY
	if ( !shaderStream.is_open() ) shaderStream = std::ifstream( FindCommonFile_ELTE_DEV_ONLY( _fileName ) );
#endif
	if ( !shaderStream.is_open() )
	{
		SDL_LogMessage( SDL_LOG_CATEGORY_ERROR,
						SDL_LOG_PRIORITY_ERROR,
						"Error while opening shader code file %s!", _fileName.string().c_str());
		return;
	}

	//:H: file tartalmának betöltése a shaderCode string-be :E: loading the file's contents into shaderCode
	std::string line = "";
#ifdef ELTE_DEV_ONLY
	bool macroELTEMacroApplied = false;
	uint32_t lineNo = 1;
#endif
	while ( std::getline( shaderStream, line ) )
	{
		shaderCode += line + "\n";
#ifdef ELTE_DEV_ONLY

		if ( !macroELTEMacroApplied && std::string::npos != line.find( "#version" ) )
		{
			shaderCode += "#define ELTE_DEV_ONLY\n#line " + std::to_string( lineNo ) + "\n";
			macroELTEMacroApplied = true;
		}
		lineNo++;

#endif
	}

	shaderStream.close();
}

GLuint AttachShader( const GLuint programID, GLenum shaderType, const std::filesystem::path& _fileName )
{
	//:H: shaderkód betoltese _fileName fájlból :E: loading in shader code from the _fileName file
    std::string shaderCode;
    loadShaderCode( shaderCode, _fileName );

    return AttachShaderCode( programID, shaderType, shaderCode );
}

GLuint AttachShaderCode( const GLuint programID, GLenum shaderType, std::string_view shaderCode )
{
	if (programID == 0)
	{
		SDL_LogMessage(SDL_LOG_CATEGORY_ERROR,
						SDL_LOG_PRIORITY_ERROR,
						"Program needs to be inited before loading!");
		return 0;
	}

	//:H: shader létrehozása :E: creating the shader
	GLuint shaderID = glCreateShader( shaderType );

	//:H: kód hozzárendelése a shader-hez :E: assigning code to the shader
	const char* sourcePointer = shaderCode.data();
	GLint sourceLength = static_cast<GLint>( shaderCode.length() );

	glShaderSource( shaderID, 1, &sourcePointer, &sourceLength );

	//:H: shader lefordítása :E: compiling the shader
	glCompileShader( shaderID );

	//:H: ellenőrizzük, hogy minden rendben van-e :E: check if everything is okay
	GLint result = GL_FALSE;
	int infoLogLength;

	//:H: fordítas státuszának lekérdezése :E: getting the status of the compiling
	glGetShaderiv( shaderID, GL_COMPILE_STATUS, &result );
	glGetShaderiv( shaderID, GL_INFO_LOG_LENGTH, &infoLogLength );

	if ( GL_FALSE == result || infoLogLength != 0 )
	{
		//:H: hibaüzenet elkérése es kiírasa :E: getting the error message and printing it
		std::string ErrorMessage( infoLogLength, '\0' );
		glGetShaderInfoLog( shaderID, infoLogLength, NULL, ErrorMessage.data() );

		SDL_LogMessage( SDL_LOG_CATEGORY_ERROR,
						( result ) ? SDL_LOG_PRIORITY_WARN : SDL_LOG_PRIORITY_ERROR,
						"[glCompileShader]: %s", ErrorMessage.data() );
	}

	//:H: shader hozzárendelése a programhoz :E: assigning the shader to the program
	glAttachShader( programID, shaderID );

	return shaderID;

}

void LinkProgram( const GLuint programID, bool OwnShaders )
{
	//:H: illesszük össze a shadereket (kimenő-bemenő változók összerendelése stb.)
	//:E: link the shaders (linking input and output variables, etc.)
	glLinkProgram( programID );

	//:H: linkelés ellenőrzése :E: checking the link
	GLint infoLogLength = 0, result = 0;

	glGetProgramiv( programID, GL_LINK_STATUS, &result );
	glGetProgramiv( programID, GL_INFO_LOG_LENGTH, &infoLogLength );
	if ( GL_FALSE == result || infoLogLength != 0 )
	{
		std::string ErrorMessage( infoLogLength, '\0' );
		glGetProgramInfoLog( programID, infoLogLength, nullptr, ErrorMessage.data() );
		SDL_LogMessage( SDL_LOG_CATEGORY_ERROR,
						( result ) ? SDL_LOG_PRIORITY_WARN : SDL_LOG_PRIORITY_ERROR,
						"[glLinkProgram]: %s", ErrorMessage.data() );
	}

	//:H: Ebben az esetben a program objektumhoz tartozik a shader objektum.
	//:H: Vagyis a shader objektumokat ki tudjuk "törölni".
    //:H: Szabvány szerint (https://registry.khronos.org/OpenGL-Refpages/gl4/html/glDeleteShader.xhtml)
    //:H: a shader objektumok csak akkor törlődnek, ha nincsennek hozzárendelve egyetlen program objektumhoz sem.
	//:H: Vagyis mikor a program objektumot töröljük, akkor törlődnek a shader objektumok is.
	//:E: In this case, the shader object is attached to the program object.
	//:E: Which means we can "delete" the shader object.
	//:E: According to the standard (https://registry.khronos.org/OpenGL-Refpages/gl4/html/glDeleteShader.xhtml)
	//:E: the shader objects will only be deleted, when they are no longer attached to any program objects.
	//:E: Therefore, when we delete the program object, the shader objects will be deleted as well.
	if ( OwnShaders )
	{
		//:H: kerjük le a program objektumhoz tartozó shader objektumokat, ... :E: get the shader objects attached to the program object, ...
        GLint attachedShaders = 0;
        glGetProgramiv( programID, GL_ATTACHED_SHADERS, &attachedShaders );
        std::vector<GLuint> shaders( attachedShaders );

        glGetAttachedShaders( programID, attachedShaders, nullptr, shaders.data() );

        // ... :H: és "töröljük" őket :E: and "delete" them
        for ( GLuint shader : shaders )
        {
            glDeleteShader( shader );
        }

	}
}

static inline ImageRGBA::TexelRGBA* get_image_row( ImageRGBA& image, int rowIndex )
{
	return &image.texelData[  rowIndex * image.width ];
}

static void invert_image_RGBA(ImageRGBA& image)
{
	int height_div_2 = image.height / 2;


	for ( int index = 0; index < height_div_2; index++ )
	{
		std::uint32_t* lower_data  =reinterpret_cast<std::uint32_t*>(get_image_row( image, index) );
		std::uint32_t* higher_data =reinterpret_cast<std::uint32_t*>(get_image_row( image, image.height - 1 - index ) );

		for ( unsigned int rowIndex = 0; rowIndex < image.width; rowIndex++ )
		{
			lower_data[ rowIndex ] ^= higher_data[ rowIndex ];
			higher_data[ rowIndex ] ^= lower_data[ rowIndex ];
			lower_data[ rowIndex ] ^= higher_data[ rowIndex ];
		}
	}
}

GLsizei NumberOfMIPLevels( const ImageRGBA& image )
{
	GLsizei targetlevel = 1;
	unsigned int index = std::max( image.width, image.height );

	while (index >>= 1) ++targetlevel;

	return targetlevel;
}

[[nodiscard]] ImageRGBA ImageFromFile( const std::filesystem::path& fileName, bool needsFlip )
{
	ImageRGBA img;

	//:H: Kép betöltése :E: Loading the image
	std::unique_ptr<SDL_Surface, decltype( &SDL_DestroySurface )> loaded_img( IMG_Load( fileName.string().c_str() ), SDL_DestroySurface );
#ifdef ELTE_DEV_ONLY
	if (!loaded_img) loaded_img.reset( IMG_Load(FindCommonFile_ELTE_DEV_ONLY(fileName).string().c_str() ));
#endif
	if ( !loaded_img )
	{
		SDL_LogMessage( SDL_LOG_CATEGORY_ERROR, 
						SDL_LOG_PRIORITY_ERROR,
						"[ImageFromFile] Error while loading image file: %s", fileName.string().c_str());
		return img;
	}

	//:H: Uint32-ben tárolja az SDL a színeket, ezért számít a bájtsorrend :E: SDL stores colors in Uint32, so the byte order matters here
#if SDL_BYTEORDER == SDL_LIL_ENDIAN
	SDL_PixelFormat format = SDL_PIXELFORMAT_ABGR8888;
#else
	SDL_PixelFormat format = SDL_PIXELFORMAT_RGBA8888;
#endif

	//:H: Átalakítás 32bit RGBA formátumra, ha nem abban volt :E: Conversion to 32bit RGBA format, if it wasn't already in it
	std::unique_ptr<SDL_Surface, decltype( &SDL_DestroySurface )> formattedSurf( SDL_ConvertSurface( loaded_img.get(), format ), SDL_DestroySurface );

	if (!formattedSurf)
	{
		SDL_LogMessage( SDL_LOG_CATEGORY_ERROR, 
						SDL_LOG_PRIORITY_ERROR,
						"[ImageFromFile] Error while processing texture");
		return img;
	}

	//:H: Rakjuk át az SDL Surface-t az ImageRGBA-ba :E: Re-assign the SDL Surface into the ImageRGBA
	img.Assign( reinterpret_cast<const std::uint32_t*>(formattedSurf->pixels), formattedSurf->w, formattedSurf->h );

	//:H: Áttérés SDL koordinátarendszerről ( (0,0) balfent ) OpenGL textúra-koordinátarendszerre ( (0,0) ballent )
	//:E: Conversion from SDL coordinates ( (0,0) upper left corner ) to OpenGL texture coordinates ( (0,0) lower left corner )

	if ( needsFlip ) invert_image_RGBA( img );

	return img;
}

void CleanOGLObject( OGLObject& ObjectGPU )
{
	glDeleteBuffers(1,      &ObjectGPU.vbo);
	ObjectGPU.vbo = 0;
	glDeleteBuffers(1,      &ObjectGPU.iboID);
	ObjectGPU.iboID = 0;
	glDeleteVertexArrays(1, &ObjectGPU.vaoID);
	ObjectGPU.vaoID = 0;
}