shader_type canvas_item;
render_mode blend_mul;

uniform float STRIPES;
uniform float XOFFSET;
uniform float YOFFSET;
uniform float ANGLE;

void vertex() {
	float radAngle = ANGLE * PI / 180.0;
	// ROTATION
	mat2 rotationTrans = mat2(
		vec2(cos(radAngle), -sin(radAngle)),
		vec2(sin(radAngle),  cos(radAngle))
	);
	VERTEX -= vec2(256.0);
	vec2 texCoord = vec2(VERTEX.xy);
	texCoord = rotationTrans * texCoord;
	VERTEX = texCoord;
	VERTEX += vec2(256.0);
	// OFFSET
	VERTEX += vec2(XOFFSET , YOFFSET);
}

// GRATING
void fragment() {
	float x_rel = (UV.x - 0.5);
	float y_rel = (UV.y - 0.5);
	float dist = sqrt(x_rel*x_rel+y_rel*y_rel);
	COLOR.a = 0.0;
	if (dist < 0.5) {
		float c = sign(sin(PI * 2.0 * dist * STRIPES * 2.0));
		COLOR = vec4(c, c, c, 1.0);
	}
}