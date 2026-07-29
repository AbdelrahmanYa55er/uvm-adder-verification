# RTL – Design Under Test (DUT)

This directory contains the synthesizable RTL design being verified.

## `design.sv` — 8-bit Synchronous Adder

A simple registered adder with:

- **Inputs**: `in1[7:0]`, `in2[7:0]`, `clk`, `reset`
- **Output**: `out[8:0]` (9-bit to accommodate carry)
- **Behavior**: On each rising clock edge, `out <= in1 + in2`. On reset, `out <= 0`.

### Port Map

| Port    | Direction | Width | Description              |
| :------ | :-------- | :---- | :----------------------- |
| `clk`   | input     | 1     | System clock             |
| `reset` | input     | 1     | Active-high sync reset   |
| `in1`   | input     | 8     | Operand A                |
| `in2`   | input     | 8     | Operand B                |
| `out`   | output    | 9     | Sum (registered output)  |

> **Note for QA**: // We can inject error here ****` — this is an intentional hook for fault injection testing. Change `in1 + in2` to something like `in1 + in2 + 1` to verify the scoreboard catches mismatches.
