`ifndef ADDER_DRIVER_SVH
`define ADDER_DRIVER_SVH

class adder_driver extends uvm_driver #(adder_transaction);

  virtual add_if vif;

  `uvm_component_utils(adder_driver)

  function new(
    string name = "adder_driver",
    uvm_component parent = null
  );
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual add_if)::get(
      this,
      "",
      "vif",
      vif
    )) begin
      `uvm_fatal(
        get_type_name(),
        "Virtual interface was not set"
      )
    end
  endfunction

  task run_phase(uvm_phase phase);

    vif.item_valid = 0;
    vif.ip1 = 0;
    vif.ip2 = 0;

    // Do not accept the first item until reset is complete.
    wait (vif.reset == 0);

    forever begin
      seq_item_port.get_next_item(req);

      // Drive stable inputs halfway before the DUT's active edge.
      @(negedge vif.clk);
      vif.ip1 = req.ip1;
      vif.ip2 = req.ip2;
      vif.item_valid = 1;

      // The DUT captures the operands and updates out on this edge.
      @(posedge vif.clk);

      // Keep item_valid asserted through the DUT edge, then clear it.
      @(negedge vif.clk);
      vif.item_valid = 0;

      seq_item_port.item_done();
    end

  endtask

endclass

`endif
