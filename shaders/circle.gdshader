shader_type canvas_item;
uniform vec4 circle_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
    // UV goes from (0,0) at top-left to (1,1) at bottom-right
    float dist = distance(UV, vec2(0.5, 0.5));
    
    float alpha = 1.0 - smoothstep(0.08, 0.3, dist);
    
    // Apply the chosen color and the calculated transparency
    COLOR = vec4(vec3(sin(TIME*10.0)), alpha);
}