# Digital IC Design Portfolio – Phan Ky Dat

RTL design, verification (simulation and formal) and RTL-to-GDSII implementation exercises completed during the **GreenChips IC Design Training**, on the open-source SkyWater **SKY130** flow.

| # | Project | What it shows | Tools | Result |
|---|---------|---------------|-------|--------|
| 01 | [8-bit ALU](01-alu-8bit) | Combinational RTL, self-checking testbench | Verilog, Icarus/ModelSim | 12 operations, 4 flags, 14 directed test cases |
| 02 | [RGB Color Mixer](02-rgb-mixer) | Sequential RTL: debounce, quadrature encoder, PWM | Verilog, cocotb, GTKWave | All cocotb tests pass |
| 03 | [Formal: timer](03-formal-timer) | Cover and assert properties, `$past()` | Yosys, SymbiYosys | PASS |
| 04 | [Formal: Caravel wrapper](04-formal-wrapper) | Proving outputs are isolated when inactive | SymbiYosys | Proof PASS |
| 05 | [OpenLane: RGB Mixer to GDSII](05-openlane-rgb-mixer) | Synthesis → floorplan → placement → CTS → routing → signoff | OpenLane, OpenROAD, Magic, KLayout | 522 cells, 100 MHz met, 0 DRC, 0 LVS errors |

## Implementation results (project 05)

| Metric | Value |
|---|---|
| Technology | SkyWater SKY130 (sky130_fd_sc_hd) |
| Die area | 150 µm × 150 µm (0.0225 mm²) |
| Core area | 17,760 µm² |
| Standard cells after synthesis | 522 |
| Target clock | 10 ns (100 MHz) |
| Worst setup slack / hold slack | +6.60 ns / +0.31 ns |
| Setup/hold violations (WNS, TNS) | 0 / 0 |
| Magic DRC / KLayout DRC | 0 / 0 |
| LVS errors | 0 |
| Antenna violations | 0 |

## Acknowledgements

Exercise structure, Makefiles and cocotb test benches come from the course material (based on Matt Venn's *Zero to ASIC* projects). The RTL in `src/`, the formal properties, the OpenLane configuration and the debugging of each design are my own work.
