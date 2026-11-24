
# UART Implementation Using Verilog HDL and Xilinx Vivado

## Overview

This project implements a Universal Asynchronous Receiver and Transmitter (UART) using Verilog HDL. The design is developed and simulated using Xilinx Vivado.

The UART system consists of a Baud Rate Generator, UART Transmitter, UART Receiver, and Top Module. A Verilog testbench is developed to verify the functionality of the complete UART system through loopback communication.

## Design Specifications

| Parameter | Value |
|---|---|
| Clock Frequency | 50 MHz |
| Baud Rate | 9600 bps |
| Data Bits | 8 |
| Start Bit | 1 |
| Stop Bit | 1 |
| Parity | None |
| Frame Format | 8N1 |
| RX Oversampling | 16x |

## Project Architecture

The UART design is divided into four main RTL modules.

### 1. Baud Rate Generator

Generates enable signals for the UART transmitter and receiver based on the system clock frequency and baud rate.

### 2. UART Transmitter

Converts 8-bit parallel data into serial data.

The transmitter uses four FSM states:

- IDLE
- START
- DATA
- STOP

### 3. UART Receiver

Receives serial data and converts it into 8-bit parallel data using a 16x oversampling technique.

The receiver uses three FSM states:

- START
- DATA_OUT
- STOP

### 4. UART Top Module

Connects the Baud Rate Generator, Transmitter, and Receiver into one complete UART system.

## Project Structure

```text
UART-Implementation-Using-Verilog-and-Vivado/
│
├── rtl/
│   ├── baud_rate_generator.v
│   ├── transmitter.v
│   ├── receiver.v
│   └── uart_top.v
│
├── tb/
│   └── uart_tb.v
│
├── images/
│   └── uart_waveform.png
│
└── README.md
```

### Folder Description

- **rtl/**: Contains all Verilog RTL design modules.
- **tb/**: Contains the Verilog testbench used for simulation.
- **images/**: Contains the Vivado simulation waveform screenshot.
- **README.md**: Contains project documentation and simulation results.

## Simulation and Verification

The complete UART design was simulated using Xilinx Vivado Behavioral Simulation.

An internal loopback connection was used, where the transmitter output (TX) was connected to the receiver input (RX).

Two test cases were performed:

| Test Case | Transmitted Data | Received Data | Result |
|---|---|---|---|
| 1 | 8'h41 | 8'h41 | PASS |
| 2 | 8'h55 | 8'h55 | PASS |

## Waveform

The following waveform was obtained from the Vivado behavioral simulation of the UART transmitter and receiver.

It shows the UART loopback communication, including transmission and reception of the test data bytes `0x41` and `0x55`.

![UART Simulation Waveform](images/uart_waveform.png)

### Waveform Signals

- `clk`: 50 MHz system clock.
- `rst`: Active-high reset signal.
- `tx`: Serial data transmitted by the UART transmitter.
- `rx`: Serial data received by the UART receiver.
- `data_out`: Received 8-bit parallel data.
- `rdy`: Indicates that received data is ready.

Both test cases passed successfully:

- First test: `0x41` — PASSED
- Second test: `0x55` — PASSED

## Tools and Technologies

- Verilog HDL
- Xilinx Vivado
- Vivado XSim Simulator
- Visual Studio Code

## Project Status

- [x] Baud Rate Generator
- [x] UART Transmitter
- [x] UART Receiver
- [x] UART Top Module
- [x] Verilog Testbench
- [x] Behavioral Simulation
- [x] Loopback Verification

## Future Work

- [ ] FPGA Synthesis and Implementation
- [ ] XDC Pin Constraints
- [ ] Bitstream Generation
- [ ] Hardware Testing on an FPGA Development Board
- [ ] Communication with an External UART Device

## Conclusion

A UART Transmitter and Receiver have been successfully designed using Verilog HDL and simulated using Xilinx Vivado.

The design successfully transmitted and received two 8-bit data values through loopback communication. Both test cases passed behavioral simulation.

This project provides practical experience with UART communication, Finite State Machines (FSM), baud rate generation, serial data transmission, and reception using Verilog HDL.

---

**Project:** UART Implementation Using Verilog HDL  
**Tool:** Xilinx Vivado  
**Language:** Verilog HDL  
**Simulation:** Vivado XSim
