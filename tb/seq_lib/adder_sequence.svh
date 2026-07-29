`ifndef ADDER_SEQUENCE_SVH
`define ADDER_SEQUENCE_SVH

class adder_sequence extends uvm_sequence #(adder_transaction);

  `uvm_object_utils(adder_sequence)

  function new(string name = "adder_sequence");
    super.new(name);
  endfunction

  task body();
    adder_transaction req;

    `uvm_info(
      get_type_name(),
      $sformatf("Generating %0d transactions", NUM_TRANSACTIONS),
      UVM_LOW
    )

    repeat (NUM_TRANSACTIONS) begin
      req = adder_transaction::type_id::create("req");

      start_item(req);

      if (!req.randomize()) begin
        `uvm_fatal(
          get_type_name(),
          "Transaction randomization failed"
        )
      end

      finish_item(req);
    end
  endtask

endclass

`endif
