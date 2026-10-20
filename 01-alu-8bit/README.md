# 8-bit ALU

Combinational 8-bit ALU in Verilog with a 4-bit opcode and four status flags.

- **Operations:** 12 opcodes (`0000`–`1011`): ADD, SUB, AND, OR, XOR, NOT, shift left, shift right, EQUAL, LESS, INC, DEC.
- **Flags:** carry/borrow, zero, signed overflow, negative.
- **Design note:** every output gets a default value at the top of the `always @(*)` block so synthesis never infers a latch.
- **Verification:** `tb_alu_8bit.v` is a self-checking testbench. A `run_test` task applies inputs and compares the result and all four flags against expected values, printing PASS/FAIL and a final count (14 directed test cases).

## Run

```sh
iverilog -o alu_sim.vvp tb_alu_8bit.v alu_8bit.v
vvp alu_sim.vvp
```
