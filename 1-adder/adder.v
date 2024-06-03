module adder(
    input [15:0] a, b,
	 output [15:0] sum );
    assign sum = a + b;
endmodule


module adder_tb ;
reg [15:0] a; 
reg [15:0] b;
wire [15:0] sum ;

adder add1 (
.sum(sum),
.a(a),
.b(b));
initial begin 
a=16'h1230;
b=16'h2214;
end
always #1 b=b+1'b1;
always #2 a=a+1'b1;
initial #500 $finish ;
endmodule