module multiplier_tb;
 
reg [3:0] A, B;
wire [7:0] P;
 
mul mul1 (.A(A), .B(B), .P(P));
 
initial begin
    $monitor("A = %b, B = %b, P = %b", A, B, P);
    A = 4'b0000; B = 4'b0000; #5;
    A = 4'b0001; B = 4'b0001; #5;
    A = 4'b0010; B = 4'b0010; #5;
    A = 4'b0011; B = 4'b0001; #5;
    A = 4'b0100; B = 4'b0100; #5;
    A = 4'b0101; B = 4'b0011; #5;
    A = 4'b0110; B = 4'b1100; #5;
    A = 4'b0111; B = 4'b1010; #5;
    A = 4'b1000; B = 4'b1000; #5;
    A = 4'b1010; B = 4'b1101; #5;
    A = 4'b1100; B = 4'b1011; #5;
    A = 4'b1110; B = 4'b1110; #5;
end
initial #500 $finish ; 
endmodule