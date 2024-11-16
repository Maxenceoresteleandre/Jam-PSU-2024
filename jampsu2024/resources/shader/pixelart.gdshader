shader_type canvas_item;

// --- Uniforms --- //
uniform float resolution: hint_range(0.0, 128.0, 1.0) = 32.0;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

// --- Functions --- //
void fragment() {
	COLOR = texture(screen_texture, round(UV * (resolution + 1.0) - (UV - 0.5)) / (resolution + 1.0));
}
