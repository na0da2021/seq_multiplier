module mux2_1_tb;
    reg [3:0] mux_in_a, mux_in_b;
    reg mux_sel;
    wire [3:0] mux_out;

    mux2_1 dut (
        .mux_in_a(mux_in_a),
        .mux_in_b(mux_in_b),
        .mux_sel(mux_sel),
        .mux_out(mux_out)
    );

    initial begin
        $monitor("Time = %t | mux_in_a = %b | mux_in_b = %b | mux_sel = %b | mux_out = %b", $time, mux_in_a, mux_in_b, mux_sel, mux_out);
        // Test case 1: mux_sel = 0, mux_in_a = 0101, mux_in_b = 1010
        mux_sel = 0;
        mux_in_a = 4'b0101;
        mux_in_b = 4'b1010;
        #10; // Delay after setting inputs

        // Test case 2: mux_sel = 1, mux_in_a = 1100, mux_in_b = 0011
        mux_sel = 1;
        mux_in_a = 4'b1100;
        mux_in_b = 4'b0011;
        #10; // Delay after setting inputs
    end
initial #500 $finish ;	 
endmodule
