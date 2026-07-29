`ifndef ADDER_MONITOR_SVH
`define ADDER_MONITOR_SVH

class adder_monitor extends uvm_monitor;

  virtual add_if vif;

  uvm_analysis_port #(adder_transaction) item_collect_port;

  `uvm_component_utils(adder_monitor)

  function new(
    string name = "adder_monitor",
    uvm_component parent = null
  );
    super.new(name, parent);
    item_collect_port = new("item_collect_port", this);
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
    adder_transaction mon_item;

    forever begin
      @(posedge vif.clk);

      if (!vif.reset && vif.item_valid) begin
        // Wait until the DUT's nonblocking assignment updates out.
        #1ps;

        mon_item =
          adder_transaction::type_id::create("mon_item");

        mon_item.ip1 = vif.ip1;
        mon_item.ip2 = vif.ip2;
        mon_item.out = vif.out;

        item_collect_port.write(mon_item);
      end
    end

  endtask

endclass

`endif
