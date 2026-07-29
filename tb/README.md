# Testbench (`tb/`)

This directory contains the complete UVM verification environment for the adder DUT.

## Directory Layout

```
tb/
├── interface/                  # Interfaces & shared definitions
│   └── add_if.sv               #   Virtual interface to the DUT
│
├── pkg/                        # UVM Package
│   └── adder_pkg.sv            #   Package (controls compile/include order)
│
├── seq_lib/                    # Sequence library
│   ├── adder_transaction.svh   #   Sequence item (data object)
│   ├── adder_sequence.svh      #   Stimulus generation sequence
│   └── adder_sequencer.svh     #   Sequencer (transaction router)
│
├── agent/                      # UVM agent & sub-components
│   ├── adder_driver.svh        #   Drives transactions onto DUT pins
│   ├── adder_monitor.svh       #   Passively observes DUT I/O
│   └── adder_agent.svh         #   Bundles driver + sequencer + monitor
│
├── env/                        # Environment layer
│   ├── adder_scoreboard.svh    #   Reference model & checker
│   └── adder_env.svh           #   Top environment (agent + scoreboard)
│
├── tests/                      # Test classes
│   └── adder_test.svh          #   Base test (objection + sequence start)
│
└── top/                        # Top-level testbench module
    └── tb_top.sv               #   Clock gen, reset, DUT, config_db
```

## Data Flow

```
adder_sequence → sequencer → driver → DUT ← monitor → scoreboard
                                              ↑ analysis port
```

## Key Design Decisions

1. **`item_valid` signal**: The interface includes an `item_valid` flag that is *not* connected to the DUT. It is a testbench-only signal used by the monitor to know when a valid transaction is being driven — a common pattern when the DUT has no built-in handshake.

2. **Monitor timing**: The monitor waits `#1ps` after the clock edge to sample `out`. This ensures the DUT's non-blocking assignment (`<=`) has resolved before the monitor reads the output.

3. **Active/passive agent support**: The agent checks `get_is_active()` before creating the driver and sequencer, allowing it to be used in passive (monitor-only) mode.

4. **Drain time**: The test sets `phase_done.set_drain_time(this, 1ns)` to allow the last monitor callback to complete before the simulation ends.

## Online Simulation

This testbench can be directly run in browser via EDA Playground: **[https://www.edaplayground.com/x/gQKM](https://www.edaplayground.com/x/gQKM)**.
