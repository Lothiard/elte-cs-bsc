#version 150

in vec2 vs_in_pos;
 
out Vertex
{
	vec4 color;
} vertex;
 
void main()
{
	gl_Position = vec4(vs_in_pos, 0, 1);
	vertex.color = vec4(1,1,1,1);
}