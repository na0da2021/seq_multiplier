module mux2_1(
    input [3:0] mux_in_a,mux_in_b ,
    input mux_sel ,
    output reg [3:0] mux_out
    );
    
    always @(mux_in_a,mux_in_b,mux_sel)
    begin
        mux_out = mux_sel? mux_in_b:mux_in_a;
    end
endmodule