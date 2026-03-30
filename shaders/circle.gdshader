shader_type canvas_item;

void fragment() {
  
    vec2 centered_uv = UV * 2.0 - 1.0;
    float d = length(centered_uv);
    float ring_distance = abs(d - 0.8);
    float mask = smoothstep(0.05, 0.15, ring_distance);
    vec3 bg_color = vec3(0.008, 0.016, 0.15); 
    
    vec3 ring_color = vec3(0.0, 1.0, 1.0);
    vec3 final_rgb = mix(ring_color, bg_color, mask);
    
    COLOR = vec4(final_rgb, 1.0);
}