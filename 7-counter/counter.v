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