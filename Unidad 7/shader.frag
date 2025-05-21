#version 150

in vec4 vColor; // color recibido del vertex shader
out vec4 outputColor;

void main()
{
    outputColor = vColor;
}
