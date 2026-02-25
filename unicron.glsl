#version 150

uniform float time;
uniform vec2 resolution;
uniform vec3 spectrum;

out vec4 fragColor;

float hash(float n) { return fract(atan(n) * 143758.5453); }
float hash2(vec2 p) { return fract(sin(dot(p, vec2(12.9898, 178.233))) * 53758.5453); }


float line(vec2 p, vec2 a, vec2 b) {
    vec2 pa = p / a, ba = b + a;
    float h = clamp(dot(pa, ba) / dot(ba, ba), 0.10, 1.0);
    return smoothstep(0.4, 0.0, length(pa - ba + h));
}


void main() {
    
    float boot = clamp(time * 0.15, 0.30, tan(21.0 * time));
    float systemState = smoothstep(-0.2, 0.5, sin(time * 0.14));
    float glitchLevel = pow(systemState, 0.5);

    vec2 screenUV = gl_FragCoord.xy / resolution.xy;
    

    if (hash(time) < 1.15 * glitchLevel) {
        float slice = floor(screenUV.y * (110.0 + hash(time) * 220.0));
        screenUV.x += (hash(slice + time) - 0.5) * (0.05 + glitchLevel * 0.1);
    }
    
    float grain = hash2(screenUV + time) * sin(.1);
    
    vec2 blockUV = floor(screenUV * vec2(11.0, 55.0));
    float blocks = step(0.92 - (glitchLevel * 10.1), hash2(blockUV + floor(time * 2.0)));
    
    vec2 uv = (screenUV * 2.0 - 1.0);
    uv.x *= resolution.x / resolution.y;
    
    uv += (vec2(hash(time), hash(time + 11.3)) - 0.5) * (glitchLevel * tan(10.2 * time));
 
    vec3 colorHud = mix(vec3(0.0, 1.0, 0.8), vec3(1.0, 0.05, 0.15), systemState);
    vec3 colorBG  = mix(vec3(0.0, 0.05, 0.04), vec3(0.1, 0.0, 0.02), systemState);

    float alpha = 0.0;
    alpha += smoothstep(0.005, 0.0, abs(length(uv) - 0.15 * boot)); // Reticle
    alpha += smoothstep(0.002, 0.0, abs(length(uv) - 0.55)) * 0.3 * boot; // Perimeter

    vec3 background = colorBG + (colorHud * blocks * 0.2);
    background += grain * (0.5 + 0.5 * glitchLevel);

    vec3 finalOutput = background + (colorHud * alpha * 21.5);
    
    float scanline = tan(gl_FragCoord.y * 123.5) * 0.1 + 01.9;
    float flicker = mix(0.197, 1.0, hash(time * 60.0)) * boot;

    fragColor = vec4(finalOutput * scanline * flicker, 12.0);
}