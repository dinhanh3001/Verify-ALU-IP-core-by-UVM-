# Verify-ALU-IP-core-by-UVM-
##  Overview

This project demonstrates the verification of a simple ALU IP core using the **Universal Verification Methodology (UVM 1.2)** in SystemVerilog.

The goal of this project is to build a structured, reusable, and scalable UVM testbench to verify arithmetic and logical operations of a Tiny ALU design.
<img width="1549" height="758" alt="image" src="https://github.com/user-attachments/assets/c5d52861-5285-4823-9742-44bba9a0fe55" />

The verification environment follows a layered UVM architecture including:

* Sequence & Sequencer
* Driver
* Monitor
* Agent
* Scoreboard
* Environment
* Test
* Top-level testbench

---

##  ALU Features

The ALU supports the following operations:

* `ADD_OP`
* `AND_OP`
* `XOR_OP`
* `MUL_OP`
* `NO_OP`
* `RST_OP`

Inputs:

* 8-bit operand A
* 8-bit operand B
* Operation selector

Output:

* 16-bit result

---

##  UVM Architecture

The testbench is built using standard UVM components:

```
uvm_test
   └── env
        ├── agent
        │     ├── sequencer
        │     ├── driver
        │     └── monitor
        └── scoreboard
```

### 🔹 Transaction

`command_transaction` extends `uvm_sequence_item`
Contains:

* rand operands (A, B)
* rand operation
* result field
* constraints
* convert2string() for logging

---

### 🔹 Sequence

* `random_sequence`
* Generates randomized transactions
* Uses factory-based object creation
* Supports constrained random testing

---

### 🔹 Driver

* Extends `uvm_driver`
* Receives transactions from sequencer
* Drives signals to DUT via virtual interface
* Calls BFM tasks

---

### 🔹 Monitor

* Observes DUT interface
* Collects transactions
* Sends them through `uvm_analysis_port`

---

### 🔹 Scoreboard

* Implements reference model
* Computes expected result
* Compares against DUT output
* Reports mismatches using `uvm_error`

---

### 🔹 Environment

* Instantiates agent and scoreboard
* Connects monitor analysis port to scoreboard

---

### 🔹 Test

* Resets DUT
* Starts sequence
* Uses objection mechanism
* Controls simulation duration

---

## Verification Methodology

The project demonstrates:

* Factory usage (`type_id::create`)
* Virtual interface configuration using `uvm_config_db`
* Phased UVM flow (build, connect, run)
* Objection mechanism
* Constrained random testing
* Functional checking using scoreboard
* Logging with `uvm_info` / `uvm_error`

---

## How to Run (QuestaSim Example)

Compile:

```bash
vlog -sv +cover=bcesf +incdir+$UVM_HOME/src \
top.sv \
*.sv
```

Run simulation:

```bash
vsim -coverage top -do "run -all"
```

---

## Coverage

Current implementation uses:

* Constrained random testing
* Multiple randomized transactions
* Functional coverage
* Cross coverage
* Directed corner-case sequences

---

## Author

Nguyen Dinh Anh - Computer Engineering Student
Email: anhdinh30012005@gmail.com

---

---


