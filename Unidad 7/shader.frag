OF_GLSL_SHADER_HEADER

varying vec3 v_pos;

uniform float u_time;
uniform vec2 u_mouse;
uniform vec2 u_resolution;

void main() {
// Color basado en la posición y el tiempo
float r = 0.5 + 0.5 * sin(u_time + v_pos.x * 0.01);
float g = 0.5 + 0.5 * sin(u_time + v_pos.y * 0.01);
float b = 0.5 + 0.5 * sin(u_time + length(v_pos.xy) * 0.01);

gl_FragColor = vec4(r, g, b, 1.0);
}
