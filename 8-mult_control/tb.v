//-----------TESTBENCH------------------
module tb();

reg clk, reset_a, start; 
reg[1:0] count;
wire[1:0] input_sel, shift_sel;
wire[2:0] state_out;
wire done, clk_ena, sclr_n;

mult_control m1(clk, reset_a, start, count, input_sel, shift_sel, state_out, done, clk_ena, sclr_n);

initial
begin
$monitor("clk is %b, reset_a is %b, start is %b, count is %b, input_sel is %b, shift_sel is %b, state_out is %b, done is %b, clk_ena is %b, sclr_n is %b", clk, reset_a, start, count, input_sel, shift_sel, state_out, done, clk_ena, sclr_n);
clk = 0;
reset_a = 0;
start = 0;
count = 0;
#12
reset_a = 1;
#12
start = 0;

#12
start = 1;

#12
start = 0;
count = 2'b00;

#12
start = 0;
count = 2'b10;

#12
start = 0;
count = 2'b11;

#12
start = 0;

end


always
begin
#5 clk = ~ clk;
end
initial #85 $finish;

endmodule