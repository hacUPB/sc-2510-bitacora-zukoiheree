OF_GLSL_SHADER_HEADER

uniform float mouseRange;
uniform vec2 mousePos;
uniform vec4 mouseColor;

void main()
{
    // copy position so we can work with it.
    vec4 pos = gl_Vertex;
    
    // direction vector from mouse position to vertex position.
	vec2 dir = pos.xy - mousePos;
    
    // distance between the mouse position and vertex position.
	float dist =  sqrt(dir.x * dir.x + dir.y * dir.y);
    
    // check vertex is within mouse range.
if(dist > 0.0 && dist < mouseRange) {
    float distNorm = dist / mouseRange;
    distNorm = 1.0 - distNorm;
    
    float intensity = sin(distNorm * 3.1415);
    dir *= distNorm * intensity * 2.0; // <- nueva intensidad dinámica
    
    pos.x += dir.x;
    pos.y += dir.y;

	}
    
	// finally set the pos to be that actual position rendered
	gl_Position = gl_ModelViewProjectionMatrix * pos;
}
