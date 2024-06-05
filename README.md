# Sequential Multiplier Module

## Overview
This module performs sequential multiplication of two 8-bit inputs, `dataa` and `datab`. The multiplication process is controlled by a start signal and is synchronous with the provided clock signal. The result is a 16-bit product, and the module also outputs a 7-segment display control.

## Module Interface

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

## Testbench

The testbench `tb` initializes the inputs, toggles the clock, and simulates the module's behavior.

## Usage

To utilize the `seq_mult` module in your Verilog projects, follow these steps:

1. **Instantiate the Module:**
   Include the `seq_mult` module in your design file and instantiate it as per your project requirements.

2. **Connect the Inputs and Outputs:**
   Map the `dataa`, `datab`, `start`, `reset_a`, and `clk` inputs to the appropriate signals in your design. Also, connect the `done_flag`, `product8x8_out`, and `seven_seg` outputs to the respective destination signals.

3. **Reset the Module:**
   Before starting the multiplication, assert the `reset_a` signal to reset the module and ensure it is in a known state.

4. **Monitor the Output:**
   The `done_flag` signal will indicate the completion of the multiplication process. Once done, the `product8x8_out` will hold the final product of the multiplication.

5. **Display Interface:**
   The `seven_seg` output can be connected to a 7-segment display to visualize the state of the module or other relevant information.

## Notes
1. Assert the reset_a signal before starting the multiplication to reset the module.

2. The done_flag output indicates the completion of the multiplication process.

