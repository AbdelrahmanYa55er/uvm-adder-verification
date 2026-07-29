`ifndef ADDER_SCOREBOARD_SVH
`define ADDER_SCOREBOARD_SVH

class adder_scoreboard extends uvm_scoreboard;

  uvm_analysis_imp #(
    adder_transaction,
    adder_scoreboard
  ) item_collect_export;

  int pass_count = 0;
  int fail_count = 0;

  `uvm_component_utils(adder_scoreboard)

  function new(
    string name = "adder_scoreboard",
    uvm_component parent = null
  );
    super.new(name, parent);
    item_collect_export =
      new("item_collect_export", this);
  endfunction

  function void write(adder_transaction req);
    logic [8:0] expected;

    expected = req.ip1 + req.ip2;

    if (req.out === expected) begin
      pass_count++;

      `uvm_info(
        get_type_name(),
        $sformatf(
          "PASS: ip1=%0d, ip2=%0d, expected=%0d, actual=%0d",
          req.ip1,
          req.ip2,
          expected,
          req.out
        ),
        UVM_LOW
      )
    end
    else begin
      fail_count++;

      `uvm_error(
        get_type_name(),
        $sformatf(
          "FAIL: %s | expected=%0d",
          req.convert2string(),
          expected
        )
      )
    end
  endfunction

  function void report_phase(uvm_phase phase);
    int checked_count;

    super.report_phase(phase);

    checked_count = pass_count + fail_count;

    `uvm_info(
      get_type_name(),
      "--- SCOREBOARD SUMMARY ---",
      UVM_NONE
    )

    `uvm_info(
      get_type_name(),
      $sformatf(
        "CHECKED: %0d | PASSED: %0d | FAILED: %0d",
        checked_count,
        pass_count,
        fail_count
      ),
      UVM_NONE
    )

    `uvm_info(
      get_type_name(),
      "--------------------------",
      UVM_NONE
    )

    if (checked_count != NUM_TRANSACTIONS) begin
      `uvm_error(
        get_type_name(),
        $sformatf(
          "Expected %0d transactions, but checked %0d",
          NUM_TRANSACTIONS,
          checked_count
        )
      )
    end

    if (fail_count > 0) begin
      `uvm_error(
        get_type_name(),
        $sformatf(
          "%0d transaction(s) failed",
          fail_count
        )
      )
    end
  endfunction

endclass

`endif
