#version 150

out vec4 outputColor;

uniform float time;

void main()
{
    // Coordenadas normalizadas entre -1.0 y 1.0
    vec2 st = gl_FragCoord.xy / vec2(800.0, 600.0); // Ajusta al tamaño de tu ventana
    st = st * 2.0 - 1.0;

    // Crear una onda animada
    float wave = sin(10.0 * st.x + time * 2.0);

    // Usar la onda para crear un color dinámico
    vec3 color = vec3(0.5 + 0.5 * wave, st.x, 1.0 - st.y);

    outputColor = vec4(color, 1.0);
}
