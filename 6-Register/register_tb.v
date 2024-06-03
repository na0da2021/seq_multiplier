module register_tb();

  // Inputs
  reg [15:0] datain;
  reg clk;
  reg sclr_n;
  reg clk_ena;

  // Outputs
  wire [15:0] reg_out;

  // Instantiate the module under test
  register reg1(
    .datain(datain),
    .clk(clk),
    .sclr_n(sclr_n),
    .clk_ena(clk_ena),
    .reg_out(reg_out)
  );

  // Clock generation
  always #5 clk = ~ clk;

  // Test case 1: clk_ena is high and sclr_n is low, expect output to be cleared
  initial begin
    clk = 0;
    datain = 16'b1111000011110000;  // Some test input data
    sclr_n = 1'b0;                    // Assert reset
    clk_ena = 1'b1;                   // Enable the clock

    #10;                          // Wait a few clock cycles

    if (reg_out !== 16'b0)
      $display("Test case 1 failed: reg_out=%b", reg_out);
    else
      $display("Test case 1 passed");


  // Test case 2: clk_ena is high and sclr_n is high, expect output to be equal to input
    #10
    datain = 16'b1010101010101010;  // Some test input data
    sclr_n = 1;                    // Release reset
    clk_ena = 1;                   // Enable the clock

    #10;                          // Wait a few clock cycles

    if (reg_out !== datain)
      $display("Test case 2 failed: reg_out=%b, datain=%b", reg_out, datain);
    else
      $display("Test case 2 passed");
  end
initial #1000 $finish;
endmodule
