# RGB Mixer: RTL to GDSII with OpenLane

The [RGB Color Mixer](../02-rgb-mixer) hardened on SkyWater SKY130 with OpenLane.

**Flow:** synthesis (Yosys) → floorplan → placement → clock tree synthesis → routing (TritonRoute) → parasitic extraction and STA → DRC (Magic, KLayout), LVS, antenna checks → GDSII.

**Configuration (`config.json`):** fixed 150 × 150 µm die, 30 % core utilization, 0.4 placement density, 10 ns clock, Magic DRC, KLayout DRC/XOR and LVS enabled.

| Metric | Value |
|---|---|
| Standard cells after synthesis | 522 |
| Die / core area | 0.0225 mm² / 17,760 µm² |
| Clock | 10 ns (100 MHz) |
| Worst setup / hold slack | +6.60 ns / +0.31 ns |
| WNS / TNS | 0 / 0 |
| Magic DRC / KLayout DRC | 0 / 0 |
| LVS errors | 0 |
| Antenna violations | 0 |

The first run did not produce a KLayout DRC result; the final run reports 0 KLayout DRC violations.

`results/` holds the final `rgb_mixer.gds`, `metrics.csv` and the signoff reports (STA summary, setup/hold paths, LVS, DRC). Open the layout with `klayout results/rgb_mixer.gds`.
