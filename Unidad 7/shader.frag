#version 150

out vec4 outputColor;

void main()
{
    float x = gl_FragCoord.x / 1024.0; // Ajusta 1024 a tu resolución de ventana si es distinta
    outputColor = vec4(x, 0.2, 1.0 - x, 1.0); // Degradado de azul a rosa
}
