# Run directly on EDA Playground: https://www.edaplayground.com/x/gQKM
#
# Manual setup on EDA Playground:
# 1. Paste tb/interface/add_if.sv        → Testbench tab
# 2. Paste tb/pkg/adder_pkg.sv           → Testbench tab
# 3. Paste tb/top/tb_top.sv              → Testbench tab
# 4. Paste rtl/design.sv                 → Design tab
# 5. Select simulator → Synopsys VCS (or Cadence Xcelium)
# 6. Under "Add +incdir+" enter the include paths or flatten includes.
#
# For a flat-file run the original testbench.sv concatenation approach
# still works; this file is kept for reference.

`timescale 1ns/1ps

`include "../tb/interface/add_if.sv"
`include "../tb/pkg/adder_pkg.sv"
`include "../tb/top/tb_top.sv"
