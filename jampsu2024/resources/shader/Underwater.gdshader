shader_type canvas_item;

uniform vec4 target_color = vec4(0.8, 0.8, 0.8, 0.5); // Default: red with 50% opacity
uniform bool enable = false;

void fragment() {
	if (enable) {
		vec4 tex_color = texture(TEXTURE, UV); // Get the color of the current pixel from the texture
	    if (tex_color.a > 0.0) {
	        // Only modify non-transparent pixels
	        COLOR = vec4(target_color.rgb, target_color.a * tex_color.a);
	    } else {
	        // Leave fully transparent pixels unchanged
	        COLOR = vec4(0.0, 0.0, 0.0, 0.0);
	    }
	}
}