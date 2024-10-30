shader_type canvas_item;
render_mode blend_mix;

uniform vec3 color;

void vertex() {
	COLOR = vec4(color, 1);
}