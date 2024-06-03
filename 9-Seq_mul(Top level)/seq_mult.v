module seq_mult(input[7:0]   dataa, datab,
                input        start, reset_a, clk, 
					 output       done_flag,
					 output[15:0] product8x8_out,                 					     
					 output[6:0]  seven_seg );
					 
wire [1:0]count,sel,shift;
wire [2:0]state_out;
wire clk_ena,sclr_n;
wire [3:0]aout,bout;
wire [7:0]product;
wire [15:0]shift_out,sum;

counter coun1         (clk, !start, count);
mult_control c1       (clk, reset_a, start, count, sel, shift, state_out, done_flag, clk_ena, sclr_n);					 
mux2_1 m1             (dataa[3:0], dataa[7:4], sel[1], aout[3:0]);
mux2_1 m2             (datab[3:0], datab[7:4], sel[0], bout[3:0]);
mul mul1              (aout[3:0], bout[3:0], product);
Shifter sh1           (product, shift, shift_out);
adder add1            (shift_out, product8x8_out, sum);
register reg1   (sum, clk, sclr_n, clk_ena, product8x8_out);
seven_seg seg1        (state_out,seven_seg[0], seven_seg[1], seven_seg[2], seven_seg[3],seven_seg[4],seven_seg[5],seven_seg[6]);

endmodule