#pragma once

#include <filesystem>
#include <vector>

#include <GL/glew.h>
#include <glm/glm.hpp>

/* 

:H: Az http://www.opengl-tutorial.org/ oldal alapján.
:E: Based on http://www.opengl-tutorial.org/

*/

//:H: Segédosztályok :E: Helper classes

struct VertexPosColor
{
    glm::vec3 position;
    glm::vec3 color;
};

struct VertexPosTex
{
    glm::vec3 position;
    glm::vec2 texcoord;
};

struct Vertex
{
    glm::vec3 position;
    glm::vec3 normal;
    glm::vec2 texcoord;
};

struct ImageRGBA
{
    typedef glm::u8vec4 TexelRGBA;

    static_assert( sizeof( TexelRGBA ) == sizeof( std::uint32_t ) );


    std::vector<TexelRGBA> texelData;
    unsigned int width		   = 0;
    unsigned int height		   = 0;

    bool Allocate( unsigned int _width, unsigned int _height )
    {
        width = _width;
        height = _height;

        texelData.resize( width * height );

        return !texelData.empty();
    }

    bool Assign( const std::uint32_t* _TexelData, unsigned int _width, unsigned int _height )
    {
        width = _width;
        height = _height;

        const TexelRGBA* _data = reinterpret_cast<const TexelRGBA*>( _TexelData );

        texelData.assign( _data, _data + width * height );

        return !texelData.empty();
    }

    TexelRGBA GetTexel( unsigned int x, unsigned int y ) const
    {
        return texelData[y * width + x];
    }

    void SetTexel( unsigned int x, unsigned int y,const TexelRGBA& texel )
    {
        texelData[y * width + x] = texel;
    }

    const TexelRGBA* data() const
    {
        return texelData.data();
    }
};

template<typename VertexT>
struct MeshObject
{
    std::vector<VertexT> vertexArray;
    std::vector<GLuint>  indexArray;
};

struct OGLObject
{
    GLuint  vaoID = 0; //:H: Vertex Array Object erőforrás azonosító :E: Vertex Array Object resource identifier
    GLuint  vbo = 0; //:H: Vertex Buffer Object erőforrás azonosító :E: Vertex Buffer Object resource identifier
    GLuint  iboID = 0; //:H: Index Buffer Object erőforrás azonosító :E: Index Buffer Object resource identifier
    GLsizei count = 0; //:H: mennyi indexet/vertexet kell rajzolnunk :E: how many indices/vertices we need to draw
};


struct VertexAttributeDescriptor
{
	GLuint index = -1;
    GLuint strideInBytes = 0;
	GLint  numberOfComponents = 0;
	GLenum glType = GL_NONE;
};

//:H: Segédfüggvények :E: Helper functions

GLuint AttachShader( const GLuint programID, GLenum shaderType, const std::filesystem::path& _fileName );
GLuint AttachShaderCode( const GLuint programID, GLenum shaderType, std::string_view shaderCode );
void LinkProgram( const GLuint programID, bool OwnShaders = true );


template <typename VertexT>
[[nodiscard]] OGLObject CreateGLObjectFromMesh( const MeshObject<VertexT>& mesh, std::initializer_list<VertexAttributeDescriptor> vertexAttrDescList )
{
	OGLObject meshGPU = { 0 };


	//:H: hozzunk létre egy új VBO erőforrás nevet :E: create a new VBO resource name
	glCreateBuffers(1, &meshGPU.vbo);

	//:H: töltsük fel adatokkal a VBO-t :E: load the VBO with data
	glNamedBufferData(meshGPU.vbo,	//:H: a VBO-ba töltsünk adatokat :E: load this VBO
					   mesh.vertexArray.size() * sizeof(VertexT),		//:H: ennyi bájt nagyságban :E: with this many bites
					   mesh.vertexArray.data(),	//:H: erről a rendszermemóriabeli címről olvasva :E: reading from this system memory address
					   GL_STATIC_DRAW);	//:H: úgy, hogy a VBO-nkba nem tervezünk ezután írni és minden kirajzoláskor felhasnzáljuk a benne lévő adatokat :E: and we are not planning on writing more to the VBO, and we use the data inside it every time we draw

	//:H: index puffer létrehozása :E: create index buffer
	glCreateBuffers(1, &meshGPU.iboID);
	//glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, meshGPU.iboID);
	glNamedBufferData(meshGPU.iboID, mesh.indexArray.size() * sizeof(GLuint), mesh.indexArray.data(), GL_STATIC_DRAW);

	meshGPU.count = static_cast<GLsizei>(mesh.indexArray.size());

	//:H: 1 db VAO foglalása :E: reserving 1 VAO
	glCreateVertexArrays(1, &meshGPU.vaoID);
	//:H: a frissen generált VAO beallítasa aktívnak :E: setting the freshly generated VAO to active

	glVertexArrayVertexBuffer( meshGPU.vaoID, 0, meshGPU.vbo, 0, sizeof( VertexT ) );

	//:H: attribútumok beállítása :E: setting up the attributes
	for ( const auto& vertexAttrDesc: vertexAttrDescList )
	{
		glEnableVertexArrayAttrib( meshGPU.vaoID, vertexAttrDesc.index ); //:H: engedélyezzük az attribútumot :E: allow the attribute
		glVertexArrayAttribBinding( meshGPU.vaoID, vertexAttrDesc.index, 0 ); //:H: melyik VBO-ból olvassa az adatokat :E: from which VBO it will read data

        switch ( vertexAttrDesc.glType )
        {
            
        case GL_FLOAT: //:H: Az attribútum float32-kat tartalmaz :E: The attribute contains float32 types
		    glVertexArrayAttribFormat(
		    	meshGPU.vaoID,						  //:H: a VAO-hoz tartozó attribútumokat állítjuk be :E: setting up the attributes of the VAO
		    	vertexAttrDesc.index,				  //:H: a VB-ben található adatok közül a soron következő "indexű" attribútumait állítjuk be :E: from the data found in VB, we are setting up the attributes of the next one with this "index"
		    	vertexAttrDesc.numberOfComponents,	  //:H: komponens szám :E: number of components
		    	vertexAttrDesc.glType,				  //:H: adatok típusa :E: type of data
		    	GL_FALSE,							  //:H: normalizalt legyen-e :E: should it be normalized
		    	vertexAttrDesc.strideInBytes       //:H: az attribútum hol kezdődik a sizeof(VertexT)-nyi területen belül :E: where the attribute will start within the sizeof(VertexT) sized memory
            );
            break;
        case GL_UNSIGNED_INT: //:H: Az attribútum uint-eket tartalmaz :E: The attribute will contain uint types
            glVertexArrayAttribIFormat(
                meshGPU.vaoID,						  //:H: a VAO-hoz tartozó attribútumokat állítjuk be :E: setting up the attributes of the VAO
                vertexAttrDesc.index,				  //:H: a VB-ben található adatok közül a soron következő "indexű" attribútumait állítjuk be :E: from the data found in VB, we are setting up the attributes of the next one with this "index"
                vertexAttrDesc.numberOfComponents,	  //:H: komponens szám :E: number of components
                vertexAttrDesc.glType,				  //:H: adatok típusa :E: type of data
                vertexAttrDesc.strideInBytes       //:H: az attribútum hol kezdődik a sizeof(VertexT)-nyi területen belül :E: where the attribute will start within the sizeof(VertexT) sized memory
            );
            break;
        case GL_DOUBLE: //:H: Az attribútum double-öket tartalmaz :E: The attribute will contain double types
            glVertexArrayAttribLFormat(
                meshGPU.vaoID,						  //:H: a VAO-hoz tartozó attribútumokat állítjuk be :E: setting up the attributes of the VAO
                vertexAttrDesc.index,				  //:H: a VB-ben található adatok közül a soron következő "indexű" attribútumait állítjuk be :E: from the data found in VB, we are setting up the attributes of the next one with this "index"
                vertexAttrDesc.numberOfComponents,	  //:H: komponens szám :E: number of components
                vertexAttrDesc.glType,				  //:H: adatok típusa :E: type of data
                vertexAttrDesc.strideInBytes       //:H: az attribútum hol kezdődik a sizeof(VertexT)-nyi területen belül :E: where the attribute will start within the sizeof(VertexT) sized memory
            );
            break;
        default: //:H: Minden egyébnél feltételezzük, hogy az attribútum a [0,1] vagy [-1,1] intervallum egészekkel való tömörítése :E: We assume that all the other attributes are indicating either a [0,1] or a [-1,1] interval using whole numbers
                 //:H: Ezért itt bekapcsoljuk a normalizálást. :E: This is why the normalization is turned on here.
            glVertexArrayAttribFormat(
                meshGPU.vaoID,						  //:H: a VAO-hoz tartozó attribútumokat állítjuk be :E: setting up the attributes of the VAO
                vertexAttrDesc.index,				  //:H: a VB-ben található adatok közül a soron következő "indexű" attribútumait állítjuk be :E: from the data found in VB, we are setting up the attributes of the next one with this "index"
                vertexAttrDesc.numberOfComponents,	  //:H: komponens szám :E: number of components
                vertexAttrDesc.glType,				  //:H: adatok típusa :E: type of data
                GL_TRUE,							  //:H: normalizalt legyen-e :E: should it be normalized
                vertexAttrDesc.strideInBytes       //:H: az attribútum hol kezdődik a sizeof(VertexT)-nyi területen belül :E: where the attribute will start within the sizeof(VertexT) sized memory
            );
            break;
        }

	}
	glVertexArrayElementBuffer( meshGPU.vaoID, meshGPU.iboID );

	return meshGPU;
}

void CleanOGLObject( OGLObject& ObjectGPU );

[[nodiscard]] ImageRGBA ImageFromFile( const std::filesystem::path& fileName, bool needsFlip = true );
GLsizei NumberOfMIPLevels( const ImageRGBA& );

//:H: uniform location lekérdezése a paraméterben megadott programon :E: getting the uniform location from the program indicated by the input parameter
inline GLint ul( GLuint programID, const GLchar* uniformName ) noexcept
{
    // https://registry.khronos.org/OpenGL-Refpages/gl4/html/glGetUniformLocation.xhtml
    return glGetUniformLocation( programID, uniformName );
}
//:H: uniform location lekérdezése az aktív programon :E: getting the uniform location from the active program
inline GLint ul(const GLchar* uniformName) noexcept
{
    GLint prog; glGetIntegerv(GL_CURRENT_PROGRAM, &prog);
    if (prog == 0) {
        glDebugMessageInsert(GL_DEBUG_SOURCE_APPLICATION, GL_DEBUG_TYPE_ERROR, 1, GL_DEBUG_SEVERITY_HIGH, -1, "Trying to get uniform location but no shader is active.");
        return -1;
    }
    return ul(prog, uniformName);
}



#ifdef ELTE_DEV_ONLY

inline std::filesystem::path FindCommonFile_ELTE_DEV_ONLY( const std::filesystem::path& fileName )
{
    static constexpr int MAX_FOLDER_DEPTH = 5;

    std::filesystem::path path_candidate = fileName;

    if ( std::filesystem::is_regular_file( path_candidate ) ) return path_candidate;
    path_candidate = std::filesystem::path("Common") / path_candidate;
    if ( std::filesystem::is_regular_file( path_candidate ) ) return path_candidate;

    for ( int folderDepth = 0; folderDepth < MAX_FOLDER_DEPTH; folderDepth++ )
    {
        path_candidate = std::filesystem::path("..") / path_candidate;
        if ( std::filesystem::is_regular_file( path_candidate ) ) return path_candidate;
    }

    return fileName;
}

#endif