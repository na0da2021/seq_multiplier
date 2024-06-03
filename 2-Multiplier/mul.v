module mul(input [3:0] A, B, output reg [7:0] P);
integer i;
always @(A, B)
begin
    P = 0;
    for (i = 0; i < 4; i = i + 1)
     begin
        if (B[i] == 1) 
        begin
            P = P + (A << i);
        end
    end
end
 
endmodule