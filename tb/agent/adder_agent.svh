`ifndef ADDER_AGENT_SVH
`define ADDER_AGENT_SVH

class adder_agent extends uvm_agent;

  adder_driver    drv;
  adder_sequencer seqr;
  adder_monitor   mon;

  `uvm_component_utils(adder_agent)

  function new(
    string name = "adder_agent",
    uvm_component parent = null
  );
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (get_is_active() == UVM_ACTIVE) begin
      drv  = adder_driver::type_id::create("drv", this);
      seqr = adder_sequencer::type_id::create("seqr", this);
    end

    mon = adder_monitor::type_id::create("mon", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    if (get_is_active() == UVM_ACTIVE) begin
      drv.seq_item_port.connect(
        seqr.seq_item_export
      );
    end
  endfunction

endclass

`endif
