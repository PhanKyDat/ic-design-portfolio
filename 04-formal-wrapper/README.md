# Formal verification: Caravel project wrapper

The RGB mixer sits inside a wrapper that shares the Caravel SoC's Wishbone bus, logic analyzer and I/O pins with other projects. The wrapper must not drive any shared output unless its `active` input is high.

`properties.v` proves, for every cycle:
- when `active = 1`, `wbs_ack_o`, `wbs_dat_o`, `la_data_out`, `io_out` and `io_oeb` equal the project's buffered outputs;
- when `active = 0`, all of them are 0.

Open-source formal tools do not model high-impedance `z`, so under `` `ifdef FORMAL `` the tri-state buffers are replaced with multiplexers that output 0 when inactive.

```sh
sby -f properties.sby   # prove mode, result: PASS
make test_wrapper       # cocotb simulation (needs ../02-rgb-mixer)
```
