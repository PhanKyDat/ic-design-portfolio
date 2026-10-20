# RGB Color Mixer

Three rotary encoders control the brightness of the red, green and blue channels of an RGB LED.

```
encoder A/B ──► debounce ──► encoder (8-bit up/down value) ──► PWM ──► LED channel
                 ×6               ×3                             ×3
```

| Module | Function |
|---|---|
| `debounce.v` | 8-bit shift-register history; output changes only after 8 identical samples |
| `encoder.v` | Quadrature decoder comparing current and previous A/B to count up or down |
| `pwm.v` | 8-bit free-running counter compared against `level`; output forced low on reset |
| `rgb_mixer.v` | Top level: 6 debouncers, 3 encoders, 3 PWM generators |

## Verification

cocotb test benches (from the course) check each block and the top level; all pass.

```sh
make test_debounce
make test_encoder
make test_pwm
make test_rgb_mixer
```

Waveform layouts for GTKWave are in the `*.gtkw` files. Reset clears both the PWM counter and the PWM output itself, so the LED is guaranteed off during reset.

This design is implemented to GDSII in [05-openlane-rgb-mixer](../05-openlane-rgb-mixer).
