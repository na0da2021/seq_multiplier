module shifter_tb ;
     reg [7:0] inp ;
     reg [1:0] shift_cntrl;
     wire [15:0] shift_out ;
    
    Shifter sh1 (
    .inp(inp),
    .shift_cntrl(shift_cntrl),
    .shift_out(shift_out)
    );

    initial 

        begin 
		  $monitor("shift_cntrlshift_cntrl is %b, shift_out is %b", shift_cntrl, shift_out);
         	inp = 8'b01101110 ;
				shift_cntrl = 2'b00; 
            #12; 

            shift_cntrl = 2'b01; 
            #12; 

            shift_cntrl = 2'b10; 
            #12; 
				
				shift_cntrl = 2'b11; 	
        end 
initial #500 $finish ;

    
endmodule