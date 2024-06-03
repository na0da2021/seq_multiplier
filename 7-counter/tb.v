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