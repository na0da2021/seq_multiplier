module counter(clk, aclr_n, count_out); 
 
	input       clk; 
	input       aclr_n; 
	output[1:0] count_out;  
	 
	t_ff t1 (.clk(clk), .t(1), .reset(aclr_n), .q(count_out[0]));
   t_ff t2 (.clk(!count_out[0]), .t(1), .reset(aclr_n), .q(count_out[1]));

endmodule



module t_ff (
 input clk, t, reset,
 output reg q
);
always @(posedge clk, negedge reset)
begin
  if (reset==0)
    q=1'b0;
  else
   if (t==1)
     q<= !q ;
   else
     q<= q;
end
endmodule




module tb(); 
 
	reg clk; 
	reg aclr_n; 
	wire [1:0] count_out; 
	 
	counter counter1 (.clk(clk), .aclr_n(aclr_n), .count_out(count_out)); 
	 
	initial 
	begin 
		$monitor("count_out = %b \n", count_out); 
		clk = 0;
		aclr_n = 0; 
		#20; 
		aclr_n = 1;  
	end 
	 
always #5 clk = ~ clk; 
initial #500 $finish;  
endmodule