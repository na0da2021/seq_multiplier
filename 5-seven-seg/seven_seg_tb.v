module seven_seg_tb;
 
    reg [2:0] in;
    wire seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g;
 
    seven_seg dut (
        .in(in),
        .seg_a(seg_a),
        .seg_b(seg_b),
        .seg_c(seg_c),
        .seg_d(seg_d),
        .seg_e(seg_e),
        .seg_f(seg_f),
        .seg_g(seg_g)
    );
 
    integer i;
 
    initial begin
        $monitor("in=%d seg_a=%d seg_b=%d seg_c=%d seg_d=%d seg_e=%d seg_f=%d seg_g=%d", in, seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g);
        for (i = 0; i < 8; i = i + 1) begin
            in = i;
            #10;
        end
    end
initial #500 $finish ;
 
endmodule
