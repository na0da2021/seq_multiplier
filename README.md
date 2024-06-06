# Sequential Multiplier

## Table of Contents
- Overview
- Top-Module Interface
- Internal Signals
- Submodules
- Installation
- Simulation
- Contributing
- Notes
- Acknowledgments

## Overview
This verilog implementaion describes a sequential multiplication of two 8-bit inputs, `dataa` and `datab`. The multiplication process is controlled by a start signal and is synchronous with the provided clock signal. The result is a 16-bit product, and the module also outputs a 7-segment display control.

## Top-Module Interface `seq_mult`

```verilog
module seq_mult(
    input [7:0] dataa, datab,
    input start, reset_a, clk,
    output done_flag,
    output [15:0] product8x8_out,
    output [6:0] seven_seg
);
```
## Internal Signals

- `count`: 2-bit signal used for counting cycles during the multiplication process.
- `sel`: 2-bit selector for the input multiplexers to choose between the lower and upper nibbles of the inputs.
- `shift`: 2-bit signal to control the shift operation in the shifter submodule.
- `state_out`: 3-bit output representing the current state of the control unit.
- `clk_ena`: Clock enable signal for the register submodule.
- `sclr_n`: Active low synchronous clear signal for the register submodule.
- `aout`: 4-bit output from the first input multiplexer.
- `bout`: 4-bit output from the second input multiplexer.
- `product`: 8-bit intermediate product from the 4x4 multiplier.
- `shift_out`: 16-bit output from the shifter submodule.
- `sum`: 16-bit sum output from the adder submodule.

## Submodules

- `counter coun1`: Counts the clock cycles and provides the count signal.
- `mult_control c1`: Manages the overall control logic for the multiplication process.
- `mux2_1 m1`, `m2`: Multiplexers for selecting the input nibbles based on the sel signal.
- `mul mul1`: Multiplies the 4-bit inputs to produce an 8-bit product.
- `Shifter sh1`: Shifts the intermediate product based on the shift signal.
- `adder add1`: Adds the shifted product to the current value of the product register.
- `register reg1`: Stores the accumulated product and outputs it as `product8x8_out`.
- `seven_seg seg1`: Drives the 7-segment display based on the state_out signal.

## Installation
1. Clone this repository to your local machine:

   git clone https://github.com/na0da2021/seq_multiplier.git

2. Navigate to the cloned directory and explore the Verilog source files.

## Simulation
1. Run the provided testbench `tb` using your preferred Verilog simulation tool (e.g., ModelSim).
2. Observe the simulation results, which demonstrate the correctness of the sequential multiplier.

## Contributing
Contributions to enhance the multiplier or extend its functionality are welcome. Fork the repository, make your changes, and submit a pull request for review.

## Notes
1. Assert the reset_a signal before starting the multiplication to reset the module.
2. The done_flag output indicates the completion of the multiplication process.

## Acknowledgments

This Sequential Multiplier project was developed through the collaborative efforts of a dedicated team.

the hard work and dedication have been instrumental in the development of this Verilog implementation. We look forward to future collaborations and continued success.
