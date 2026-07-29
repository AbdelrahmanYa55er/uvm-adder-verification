`ifndef ADDER_TRANSACTION_SVH
`define ADDER_TRANSACTION_SVH

class adder_transaction extends uvm_sequence_item;

  `uvm_object_utils(adder_transaction)

  rand bit   [7:0] ip1;
  rand bit   [7:0] ip2;
       logic [8:0] out;

  constraint ip_c {
    ip1 < 100;
    ip2 < 100;
  }

  function new(string name = "adder_transaction");
    super.new(name);
  endfunction

  function string convert2string();
    return $sformatf(
      "ip1=%0d, ip2=%0d, out=%0d",
      ip1,
      ip2,
      out
    );
  endfunction

endclass

`endif
