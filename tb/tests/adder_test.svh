`ifndef ADDER_TEST_SVH
`define ADDER_TEST_SVH

class adder_test extends uvm_test;

  adder_env env_o;

  `uvm_component_utils(adder_test)

  function new(
    string name = "adder_test",
    uvm_component parent = null
  );
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    env_o = adder_env::type_id::create(
      "env_o",
      this
    );
  endfunction

  task run_phase(uvm_phase phase);
    adder_sequence bseq;

    phase.raise_objection(this);

    bseq = adder_sequence::type_id::create("bseq");
    bseq.start(env_o.agt.seqr);

    // One nanosecond lets the final monitor callback complete.
    phase.phase_done.set_drain_time(this, 1ns);
    phase.drop_objection(this);

    `uvm_info(
      get_type_name(),
      "End of testcase",
      UVM_LOW
    )
  endtask

endclass

`endif
