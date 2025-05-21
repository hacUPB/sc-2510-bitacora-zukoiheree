OF_GLSL_SHADER_HEADER

uniform float u_time;
uniform vec2 u_mouse;
uniform vec2 u_resolution;

varying vec3 v_pos;

void main() {
vec4 pos = gl_Vertex;

// Deformación similar a olas
float wave = sin(pos.x * 0.05 + u_time) * 30.0;
wave += cos(pos.y * 0.1 + u_time * 1.5) * 20.0;

pos.z += wave;

v_pos = pos.xyz;

gl_Position = gl_ModelViewProjectionMatrix * pos;
