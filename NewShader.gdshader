shader_type canvas_item;

uniform vec2 scrollSpeed = vec2(.1,.1);

void fragment() {
	vec4 newColor = texture(TEXTURE, UV + scrollSpeed * TIME);
	COLOR = newColor;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
