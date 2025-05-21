// shader.vert (GL2)
#version 120

uniform float time;

void main()
{
    vec4 pos = gl_Vertex;
    
    // desplazamiento en Y tipo onda senoidal
    pos.y += sin(pos.x * 0.05 + time) * 20.0;
    
    gl_Position = gl_ModelViewProjectionMatrix * pos;
}
