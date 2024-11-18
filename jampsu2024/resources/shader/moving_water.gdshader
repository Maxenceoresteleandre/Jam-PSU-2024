shader_type canvas_item;

// --- Uniforms --- //
uniform vec2 motion = vec2(1.0, 0.0);
uniform float time = 0.0;

// --- Functions --- //
void fragment() {
	COLOR = texture(TEXTURE, mod(UV + time * motion, 1.0));
}