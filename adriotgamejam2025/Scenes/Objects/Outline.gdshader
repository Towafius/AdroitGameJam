shader_type canvas_item;

uniform vec4 clr1 : source_color = vec4(1.0, 0.0, 0.0, 1.0); // First color
uniform vec4 clr2 : source_color = vec4(0.0, 0.0, 1.0, 1.0); // Second color
uniform int type : hint_range(1, 2) = 2;
uniform float thickness = 1.0;
uniform float speed = 1.0; // Fade speed multiplier

const vec2[8] DIRECTIONS = {
	vec2(1.0, 0.0),
	vec2(0.0, 1.0),
	vec2(-1.0, 0.0),
	vec2(0.0, -1.0),
	vec2(1.0, 1.0),
	vec2(-1.0, 1.0),
	vec2(-1.0, -1.0),
	vec2(1.0, -1.0)
};

float gtz(float input) { return max(0.0, sign(input)); }

float check(sampler2D tex, vec2 from, vec2 size) {
	float result = 0.0;
	for (int i = 0; i < 4 * type; i++) {
		result += texture(tex, from + DIRECTIONS[i] * size * thickness).a;
	}
	return gtz(result);
}

void fragment() {
	float is_outline = check(TEXTURE, UV, TEXTURE_PIXEL_SIZE) - gtz(COLOR.a);

	if (is_outline > 0.0) {
		// Fade factor oscillates between 0 and 1
		float fade = sin(TIME * speed) * 0.5 + 0.5;
		COLOR = mix(clr1, clr2, fade);
	}
}