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