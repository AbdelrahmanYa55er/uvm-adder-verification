// Code your design here
module adder(
  input  logic       clk,
  input  logic       reset,
  input  logic [7:0] in1,
  input  logic [7:0] in2,
  output logic [8:0] out
);

  always_ff @(posedge clk or posedge reset) begin
    if (reset)
      out <= '0;
    else
      out <= in1 + in2;  // We can inject error here ****
  end

endmodule
