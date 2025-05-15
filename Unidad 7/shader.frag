uniform float time;

out vec4 outputColor;

void main()
{
    float red = 0.5 + 0.5 * sin(time);
    float green = 0.5 + 0.5 * cos(time);
    float blue = 0.5 + 0.5 * sin(time + 3.14159);

    outputColor = vec4(red, green, blue, 1.0);
}

