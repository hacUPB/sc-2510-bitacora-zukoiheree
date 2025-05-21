// shader.frag (GL2)
#version 120

void main()
{
    // Color dinámico basado en la posición de fragmento
    vec2 pos = gl_FragCoord.xy;
    float r = abs(sin(pos.x * 0.01));
    float g = abs(sin(pos.y * 0.01));
    float b = abs(sin((pos.x + pos.y) * 0.005));
    gl_FragColor = vec4(r, g, b, 1.0);
}
