# Unicron Shader

This GLSL fragment shader (`unicron.glsl`) generates a dynamic, sci-fi inspired Heads-Up Display (HUD) effect. It simulates a digital interface that transitions between a stable state and a "glitched" critical state.

## Uniforms

The shader requires the following uniform inputs:

| Name         | Type   | Description                                                                 |
|--------------|--------|-----------------------------------------------------------------------------|
| `time`       | `float`| Global time in seconds. Drives the animation, glitches, and state changes.  |
| `resolution` | `vec2` | The viewport resolution in pixels (width, height). Used for UV calculation. |
| `spectrum`   | `vec3` | Audio spectrum data (declared but currently unused in the main logic).      |

## Visual Effects

### System State & Colors
The visual style oscillates based on a `systemState` variable:
- **Stable:** Teal/Cyan color palette (`vec3(0.0, 1.0, 0.8)`).
- **Critical:** Red/Orange color palette (`vec3(1.0, 0.05, 0.15)`).

### Glitch Mechanics
The `glitchLevel` increases as the system state shifts towards critical:
- **Screen Tearing:** Horizontal bands of the screen are randomly offset (`screenUV.x`).
- **Block Artifacts:** A grid of digital noise appears over the HUD.
- **Jitter:** The entire coordinate system shakes based on `tan(time)`.

### CRT / Monitor Simulation
- **Scanlines:** Horizontal lines generated using a tangent function.
- **Grain:** High-frequency noise applied to the background.
- **Flicker:** Random intensity modulation simulating an unstable display.

### Geometry
- **Reticle:** A central circular element.
- **Perimeter:** An outer ring that frames the center.

## Code Notes

- **Version:** GLSL 1.50 (`#version 150`).
- **Output:** `fragColor` (vec4).
- **Unused Functions:** The `line` function is defined but not currently utilized in `main`.

---
*Generated for `unicron.glsl`*