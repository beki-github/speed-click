shader_type canvas_item;

const vec3 bg_color = vec3(0.008, 0.016, 0.15); 
const vec3 ring_color = vec3(1.0, 0.843, 0.0);

void fragment() {
    vec2 centered_uv = UV * 2.0 - 1.0;
    float dist_from_center = length(centered_uv); 
    
   
    float d = sin(dist_from_center * 8.0 - TIME*5.0) / 3.0;
    float ring_distance = abs(d);
    ring_distance=0.01/ring_distance;
    float mask = smoothstep(0.05, 0.15, ring_distance);
    
    float edge_fade = smoothstep(0.8, 0.95, dist_from_center);
    float final_mask = max(mask, edge_fade);
	
    
    vec3 final_rgb = mix(ring_color, bg_color, final_mask);
    
    COLOR = vec4(final_rgb, 1.0);
}