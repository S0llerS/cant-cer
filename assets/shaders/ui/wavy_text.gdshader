shader_type canvas_item;

uniform float amplitude = 0.35;
uniform float frequency = 20.0;
uniform float speed = 25.0;

void vertex() {
	VERTEX.y += amplitude * sin((frequency * UV.x) + (speed * TIME));
}