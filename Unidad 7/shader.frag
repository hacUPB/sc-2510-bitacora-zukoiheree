#version 150

out vec4 outputColor;

uniform vec4 mouseColor;

void main()
{
    // Genera colores tipo arco iris según la posición del fragmento
    vec2 st = gl_FragCoord.xy / vec2(1024.0, 768.0); // ajusta a tu resolución
    vec3 color = vec3(st.x, st.y, abs(sin(st.x * 3.14)));
    
    // Multiplica por el color del mouse para combinar efectos
    outputColor = vec4(color * mouseColor.rgb, 1.0);
}
uniform float time;

void main()
{
    float brightness = abs(sin(time));
    outputColor = vec4(mouseColor.rgb * brightness, 1.0);
}
void main()
{
    vec2 center = vec2(1024.0, 768.0) * 0.5; // reemplaza con tu resolución
    float dist = distance(gl_FragCoord.xy, center);
    float maxDist = length(center);
    float intensity = 1.0 - dist / maxDist;
    
    outputColor = vec4(mouseColor.rgb * intensity, 1.0);
}

