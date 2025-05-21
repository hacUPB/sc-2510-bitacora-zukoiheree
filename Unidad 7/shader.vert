#version 150

in vec4 position;
in vec3 normal;

uniform float u_time;
uniform vec2 u_mouse;
uniform vec2 u_resolution;

out vec3 v_normal;
out vec3 v_pos;

void main() {
vec4 pos = position;

// Deformación con ondas animadas usando el tiempo y posición
float wave = sin(pos.x * 0.05 + u_time) * 30.0;
wave += cos(pos.y * 0.1 + u_time * 1.5) * 20.0;

pos.z += wave;

v_pos = pos.xyz;
v_normal = normal;

gl_Position = modelViewProjectionMatrix * pos;
