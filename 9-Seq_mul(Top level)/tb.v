//-----------TESTBENCH------------------
module tb();
reg[7:0] dataa, datab;
reg clk, reset_a, start; 
wire done_flag;
wire[15:0] product8x8_out;                 					     
wire[6:0]  seven_seg; 

seq_mult t1(
   .dataa(dataa),
   .datab(datab),
   .start(start),
   .reset_a(reset_a),
   .clk(clk),
   .done_flag(done_flag),
   .seven_seg(seven_seg),
   .product8x8_out(product8x8_out)
);			 
initial
begin
dataa = 8'b01101110;
datab = 8'b00001010;
clk = 0;
reset_a = 0;
start = 0;
#12
reset_a = 1;
#12
start = 1;
#6
start = 0;
end


always
begin
#5 clk = ~ clk;
end
initial #500 $finish;

endmodule