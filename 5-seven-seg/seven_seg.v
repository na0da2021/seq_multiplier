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