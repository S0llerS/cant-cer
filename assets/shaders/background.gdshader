shader_type canvas_item;

uniform vec4 color_tint: source_color;

uniform vec2 direction = vec2(-0.5, -0.6);
uniform float speed: hint_range(0.0, 3.0, 0.1) = 0.75;

void fragment() {
	COLOR = texture(TEXTURE, UV + TIME * direction * speed);
	COLOR = mix(COLOR, color_tint, 0.5);
}