`timescale 1ns/1ps

module tb_top;

  import uvm_pkg::*;
  import adder_pkg::*;
  `include "uvm_macros.svh"

  bit clk;
  bit reset;

  always #2 clk = ~clk;

  add_if vif(clk, reset);

  adder DUT (
    .clk   (clk),
    .reset (reset),
    .in1   (vif.ip1),
    .in2   (vif.ip2),
    .out   (vif.out)
  );

  initial begin
    reset = 1;
    #5;
    reset = 0;
  end

  initial begin
    uvm_config_db#(virtual add_if)::set(
      null,
      "uvm_test_top.env_o.agt*",
      "vif",
      vif
    );

    $dumpfile("dump.vcd");
    $dumpvars(0, tb_top);

    run_test("adder_test");
  end

endmodule
