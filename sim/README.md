# Simulation (`sim/`)

This directory contains scripts and helpers for running the UVM testbench.

## Files

| File                    | Purpose                                                           |
| :---------------------- | :---------------------------------------------------------------- |
| `Makefile`              | Multi-simulator build & run (QuestaSim, Xcelium, VCS)             |
| `run_edaplayground.sv`  | Flat-file include reference for EDA Playground                    |
| `passing_run.log`       | Log proof of clean simulation run (0 UVM_ERROR)                   |
| `injected_bug_run.log`  | Log proof of scoreboard detecting an injected DUT bug             |

## Usage

### Makefile

All commands should be run from this directory (`sim/`).

```bash
# Default: QuestaSim
make all

# Override simulator
make SIMULATOR=xcelium all
make SIMULATOR=vcs all

# Override test name, seed, verbosity
make TEST=adder_test SEED=42 UVM_FLAGS="+UVM_VERBOSITY=UVM_HIGH" all

# Clean up
make clean
```

### Supported Variables

| Variable      | Default         | Description                    |
| :------------ | :-------------- | :----------------------------- |
| `SIMULATOR`   | `questa`        | `questa`, `xcelium`, or `vcs`  |
| `TEST`        | `adder_test`    | UVM test class name            |
| `SEED`        | `random`        | Random seed for constrained random |
| `UVM_FLAGS`   | `+UVM_VERBOSITY=UVM_LOW` | Additional UVM plusargs |

### EDA Playground

The project can be directly found and run online at **[https://www.edaplayground.com/x/gQKM](https://www.edaplayground.com/x/gQKM)**.

For manual browser-based runs, see instructions in `run_edaplayground.sv` or the main project README.
