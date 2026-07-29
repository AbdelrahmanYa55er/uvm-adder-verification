`ifndef ADDER_PKG_SV
`define ADDER_PKG_SV

package adder_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  parameter int NUM_TRANSACTIONS = 10;

  // --- Sequence library ---
  `include "../seq_lib/adder_transaction.svh"
  `include "../seq_lib/adder_sequence.svh"
  `include "../seq_lib/adder_sequencer.svh"

  // --- Agent components ---
  `include "../agent/adder_driver.svh"
  `include "../agent/adder_monitor.svh"
  `include "../agent/adder_agent.svh"

  // --- Environment ---
  `include "../env/adder_scoreboard.svh"
  `include "../env/adder_env.svh"

  // --- Tests ---
  `include "../tests/adder_test.svh"

endpackage

`endif
