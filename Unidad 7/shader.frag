#version 150

in vec3 v_normal;
in vec3 v_pos;

uniform float u_time;
uniform vec2 u_mouse;
uniform vec2 u_resolution;

out vec4 outputColor;

void main() {
// Color que varía con el tiempo y la posición
float r = 0.5 + 0.5 * sin(u_time + v_pos.x * 0.01);
float g = 0.5 + 0.5 * sin(u_time + v_pos.y * 0.01);
float b = 0.5 + 0.5 * sin(u_time + length(v_pos.xy) * 0.01);

outputColor = vec4(r, g, b, 1.0);
}
