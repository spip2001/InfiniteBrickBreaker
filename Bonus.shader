shader_type canvas_item; 
render_mode unshaded;

void fragment() {
	vec4 c = texture(TEXTURE, UV);
	if (c.a == 1.0) {
		c.g = 0.5 + sin(TIME) / 2.0;
	}
	COLOR = c;
}
