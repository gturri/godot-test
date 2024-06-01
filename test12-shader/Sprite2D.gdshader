shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
	//VERTEX += vec2(cos(TIME)*100.0, sin(TIME)*100.0);
}

void fragment() {
	COLOR = texture(TEXTURE, UV);
	float r0 = 0.;
	float r1 = 0.00001;
	float l = 0.;

	float a = (l-1.)/(r1-r0);
	float b = 1.-a*r0;

	float dx = 0.5-UV.x;
	float dy = 0.5-UV.y;
	float r = sqrt(dx*dx + dy*dy);
	
	float mult = max(min(a*r+b, 1), 0);
	COLOR.b *= mult;
	COLOR.r *= mult;
	COLOR.g *= mult;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
