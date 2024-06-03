module seven_seg(input [2:0]in,
output reg seg_a,
output reg seg_b,
output reg seg_c,
output reg seg_d,
output reg seg_e,
output reg seg_f,
output reg seg_g
 
    );
    always @(*)
      begin
      case(in)
      3'b000:begin seg_a=1;
      seg_b=1;
      seg_c=1;
      seg_d=1;
      seg_e=1;
      seg_f=1;
      seg_g=0;
      end 
      3'b001:begin seg_a=0;
            seg_b=1;
            seg_c=1;
            seg_d=0;
            seg_e=0;
            seg_f=0;
            seg_g=0;
            end 
      3'b010:begin seg_a=1;
                  seg_b=1;
                  seg_c=0;
                  seg_d=1;
                  seg_e=1;
                  seg_f=0;
                  seg_g=1;
                  end 
     3'b011:begin seg_a=1;
                        seg_b=1;
                        seg_c=1;
                        seg_d=1;
                        seg_e=0;
                        seg_f=0;
                        seg_g=1;
                        end    
    default : begin seg_a=1;
                              seg_b=0;
                              seg_c=0;
                              seg_d=1;
                              seg_e=1;
                              seg_f=1;
                              seg_g=1;
                              end                               
    endcase
    end
    
endmodule




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
