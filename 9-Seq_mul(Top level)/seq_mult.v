module seq_mult(input[7:0]   dataa, datab,
                input        start, reset_a, clk, 
					 output       done_flag,
					 output[15:0] product8x8_out,                 					     
					 output[6:0]  seven_seg );
					 
wire [1:0]count,sel,shift;
wire [2:0]state_out;
wire clk_ena,sclr_n;
wire [3:0]aout,bout;
wire [7:0]product;
wire [15:0]shift_out,sum;

counter coun1         (clk, !start, count);
mult_control c1       (clk, reset_a, start, count, sel, shift, state_out, done_flag, clk_ena, sclr_n);					 
mux2_1 m1             (dataa[3:0], dataa[7:4], sel[1], aout[3:0]);
mux2_1 m2             (datab[3:0], datab[7:4], sel[0], bout[3:0]);
mul mul1              (aout[3:0], bout[3:0], product);
Shifter sh1           (product, shift, shift_out);
adder add1            (shift_out, product8x8_out, sum);
register reg1   (sum, clk, sclr_n, clk_ena, product8x8_out);
seven_seg seg1        (state_out,seven_seg[0], seven_seg[1], seven_seg[2], seven_seg[3],seven_seg[4],seven_seg[5],seven_seg[6]);

endmodule


//////////////////////////////////
module adder(
    input [15:0] a, b,
	 output [15:0] sum );
    assign sum = a + b;
endmodule
//////////////////////////////////
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

//////////////////////////////////
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

//////////////////////////////////

module Shifter (input[7:0] inp,
                input[1:0] shift_cntrl,
                output reg [15:0] shift_out );
    
    always@(*)
    begin 
   case(shift_cntrl)
   2'b00 : shift_out = inp;
   2'b01 : shift_out = inp << 4;
   2'b10 : shift_out = inp << 8;
	2'b11 : shift_out = inp;
   endcase
    end 
endmodule
//////////////////////////////////

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

//////////////////////////////////


module register(
input wire [15:0] datain,
    input wire clk,
    input wire sclr_n,
    input wire clk_ena,
    output reg [15:0] reg_out
    );
    
    always @(posedge clk) begin
        if (clk_ena) begin
            if (!sclr_n) begin
                reg_out <= 16'b0;  // Clear the output when reset is active
            end
            else begin
                reg_out <= datain;  // Set the output equal to the input when reset is inactive
            end
        end
    end

endmodule

//////////////////////////////////


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

//////////////////////////////////


// FSM DESCRIBING MULTIPLIER CONTROLLER

// FSM DESCRIBING MULTIPLIER CONTROLLER

module mult_control(input clk, reset_a, start,
                    input[1:0] count,
                    output reg[1:0] input_sel, shift_sel, 
						  output reg[2:0] state_out, 
						  output reg done, clk_ena, sclr_n); 
						  
						  
// PRESENT AND NEXT STATE
reg [2:0] ps, ns;

// DEFINING THE STATES IN GRAY ENCODING 
localparam [2:0] idle      = 3'b000,
                 lsb       = 3'b001,
                 mid       = 3'b011,
                 msb       = 3'b010,
					  calc_done = 3'b110,
					  err       = 3'b111;	


// combuntional always block

always @(*)
begin 
input_sel = 2'b00;
shift_sel = 2'b00;
state_out = 3'b000;
done = 0;
clk_ena = 0; 
sclr_n = 0;

ns = ps ;

case (ps)
      idle :begin
		
			   if (start == 1'b1) begin
				clk_ena = 1; 
				ns = lsb;
				end
			else if (start == 1'b0)
			   sclr_n = 1'b1;		
		end
			
		lsb :begin
		      state_out = 3'b001;
			   if (start == 1'b0 && count ==2'b00) begin
				input_sel = 2'b00;
            shift_sel = 2'b00;
            done = 0;
            clk_ena = 1; 
            sclr_n = 1;
				ns = mid;
				end
			   else begin
            done = 0;
            clk_ena = 0; 
            sclr_n = 1;
		      ns = err;
		      end		
		end
	
		mid :begin
		      state_out = 3'b010;
			   if (start == 1'b0 && count == 2'b01) begin
				input_sel = 2'b01;
            shift_sel = 2'b01;
            done = 0;
            clk_ena = 1; 
            sclr_n = 1;
				ns = mid;
				end
		      else if (start == 1'b0 && count == 2'b10) begin
				input_sel = 2'b10;
            shift_sel = 2'b01;
            done = 0;
            clk_ena = 1; 
            sclr_n = 1;
				ns = msb;
				end
            else begin
            done = 0;
            clk_ena = 0; 
            sclr_n = 1;
				ns = err; 
	         end 		 
		end
		
		msb :begin
		      state_out = 3'b011;
			   if (start == 1'b0 && count == 2'b11) begin
				input_sel = 2'b11;
            shift_sel = 2'b10;
            done = 0;
            clk_ena = 1; 
            sclr_n = 1;
				ns = calc_done;
				end  
			   else begin
            done = 0;
            clk_ena = 0; 
            sclr_n = 1;
				ns = err;
		   	end	
		end
		
		calc_done :begin
		            state_out = 3'b100; 
					  if (start == 0) begin
                 done = 1;
                 clk_ena = 0; 
                 sclr_n = 1;
				     ns = idle; 
			        end   
			        else if (start == 1) begin
                 done = 0;
                 clk_ena = 0; 
                 sclr_n = 1;
				     ns = err; 
			        end     
		end
			
		err :begin
		      state_out = 3'b101;
			   if (start == 0) begin
            done = 0;
            clk_ena = 0; 
            sclr_n = 1;
				ns = err; 
				end
				else if (start == 1) begin
            done = 0;
            clk_ena = 1; 
            sclr_n = 0;
				ns = lsb; 
				end
		end
		
		default: ns = ps;
		
endcase		
end

// Feedback(seq. always block)
// asynchronus

always @ (posedge clk, negedge reset_a)

begin
 if (!reset_a) begin
     ps  <=  idle;
end	  
else	 
     ps  <=  ns; 

end 
			 
endmodule

//-----------TESTBENCH------------------
module tb();
reg[7:0] dataa, datab;
reg clk, reset_a, start; 
wire done_flag;
wire[15:0] product8x8_out;                 					     
wire[6:0]  seven_seg; 

seq_mult t1(
   .dataa(dataa),
   .datab(datab),
   .start(start),
   .reset_a(reset_a),
   .clk(clk),
   .done_flag(done_flag),
   .seven_seg(seven_seg),
   .product8x8_out(product8x8_out)
);			 
initial
begin
dataa = 8'b01101110;
datab = 8'b00001010;
clk = 0;
reset_a = 0;
start = 0;
#12
reset_a = 1;
#12
start = 1;
#6
start = 0;
end


always
begin
#5 clk = ~ clk;
end
initial #500 $finish;

endmodule