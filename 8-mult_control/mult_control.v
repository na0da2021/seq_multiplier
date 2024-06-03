
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

reg clk, reset_a, start; 
reg[1:0] count;
wire[1:0] input_sel, shift_sel;
wire[2:0] state_out;
wire done, clk_ena, sclr_n;

mult_control m1(clk, reset_a, start, count, input_sel, shift_sel, state_out, done, clk_ena, sclr_n);

initial
begin
$monitor("clk is %b, reset_a is %b, start is %b, count is %b, input_sel is %b, shift_sel is %b, state_out is %b, done is %b, clk_ena is %b, sclr_n is %b", clk, reset_a, start, count, input_sel, shift_sel, state_out, done, clk_ena, sclr_n);
clk = 0;
reset_a = 0;
start = 0;
count = 0;
#12
reset_a = 1;
#12
start = 0;

#12
start = 1;

#12
start = 0;
count = 2'b00;

#12
start = 0;
count = 2'b10;

#12
start = 0;
count = 2'b11;

#12
start = 0;

end


always
begin
#5 clk = ~ clk;
end
initial #85 $finish;

endmodule