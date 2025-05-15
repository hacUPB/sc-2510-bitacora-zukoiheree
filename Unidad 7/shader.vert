OF_GLSL_SHADER_HEADER

uniform mat4 modelViewProjectionMatrix;
in vec4 position;

uniform float mouseRange;
uniform vec2 mousePos;
uniform float time;

void main()
{
    vec4 pos = position;
    vec2 dir = pos.xy - mousePos;
    float dist = length(dir);

    if (dist < mouseRange) {
        float wave = sin(dist * 0.2 - time * 5.0);
        float attenuation = (1.0 - dist / mouseRange);
        float displacement = wave * attenuation * 20.0;
        pos.z += displacement;  // deformación en Z, como una ola
    }

    gl_Vertex = gl_ModelViewProjectionMatrix * pos;
}



