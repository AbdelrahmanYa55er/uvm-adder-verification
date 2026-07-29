# Documentation

## Architecture Overview

This project implements a standard UVM testbench following the layered architecture:

```
          ┌─────────────┐
          │    TEST     │    ← Scenario control (objection, sequence launch)
          │ ┌─────────┐ │
          │ │   ENV   │ │    ← Component composition (agent + scoreboard)
          │ │ ┌─────┐ │ │
          │ │ │AGENT│ │ │    ← Stimulus + observation bundle
          │ │ └─────┘ │ │
          │ └─────────┘ │
          └──────┬──────┘
                 │ virtual interface
          ┌──────┴───────┐
          │     DUT      │    ← Design Under Test
          └──────────────┘
```

## UVM Component Hierarchy

```
uvm_test_top (adder_test)
 └── env_o (adder_env)
      ├── agt (adder_agent)
      │    ├── drv  (adder_driver)      — Active only
      │    ├── seqr (adder_sequencer)   — Active only
      │    └── mon  (adder_monitor)     — Always present
      └── sb (adder_scoreboard)
```

## Phase Execution Order

1. **build_phase** — Create and configure components (top-down)
2. **connect_phase** — Wire TLM ports (bottom-up)
3. **run_phase** — Execute stimulus and checking (parallel)
4. **report_phase** — Print scoreboard summary

## Learning Resources

- [Live EDA Playground Environment](https://www.edaplayground.com/x/gQKM) – Direct online runnable instance of this project
- [Doulos – Easier UVM](https://www.doulos.com/knowhow/systemverilog/uvm/)
- [Accellera UVM Reference Manual](https://www.accellera.org/downloads/standards/uvm)
- [Verification Academy](https://verificationacademy.com/)
- [ChipVerify – UVM Tutorial](https://www.chipverify.com/uvm/uvm-tutorial)

## What I Learned

### QA / Verification Engineering Concepts

- **Constrained Random Verification (CRV)**: Using SystemVerilog constraints to generate legal but diverse stimulus automatically, instead of writing directed tests by hand.

- **Self-Checking Testbenches**: The scoreboard computes the expected result independently and compares it against the DUT's actual output — no manual waveform inspection required.

- **Factory Pattern & Overrides**: Every UVM component is created through `type_id::create()`, enabling test-level overrides without modifying the environment code.

- **TLM (Transaction Level Modeling)**: The monitor communicates with the scoreboard via `uvm_analysis_port`, decoupling observation from checking.

- **Objection Mechanism**: The test controls simulation lifetime through `raise_objection()` / `drop_objection()`, ensuring all transactions are processed before the simulation ends.

- **Config DB**: The virtual interface is passed from the top module to the driver and monitor via `uvm_config_db`, avoiding global variables and enabling hierarchical configuration.

### Project Organization

- Separating RTL from testbench code mirrors real project structures
- The package file (`adder_pkg.sv`) controls compile order — a common source of errors when files are compiled out of order
- Using `+incdir+` flags keeps include paths clean and simulator-portable
