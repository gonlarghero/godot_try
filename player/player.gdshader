shader_type canvas_item;

uniform bool active = false;

void fragment() {
	// texture recorre cada pixel del sprite (TEXTURE)
	// y nos dice el color de cada una de las posiciones (UV)
	vec4 previous_color = texture(TEXTURE, UV);
	vec4 white_color = vec4(1.0, 1.0, 1.0, previous_color.a);
	vec4 new_color = previous_color;
	if (active){
		new_color = white_color;
	}
	COLOR = new_color;
}
