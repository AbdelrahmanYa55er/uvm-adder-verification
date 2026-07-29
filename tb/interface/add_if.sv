interface add_if(input logic clk, input logic reset);

  // Testbench-only transaction qualifier; not connected to the DUT.
  logic item_valid;

  logic [7:0] ip1;
  logic [7:0] ip2;
  logic [8:0] out;

endinterface
