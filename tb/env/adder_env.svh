`ifndef ADDER_ENV_SVH
`define ADDER_ENV_SVH

class adder_env extends uvm_env;

  adder_agent      agt;
  adder_scoreboard sb;

  `uvm_component_utils(adder_env)

  function new(
    string name = "adder_env",
    uvm_component parent = null
  );
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    agt = adder_agent::type_id::create("agt", this);
    sb  = adder_scoreboard::type_id::create("sb", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    agt.mon.item_collect_port.connect(
      sb.item_collect_export
    );
  endfunction

endclass

`endif
