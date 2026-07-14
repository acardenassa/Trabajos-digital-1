module reg_comp(
    input clk,
    input reset,             
    input ld_comp,            
    input  [15:0] r_in,      
    output reg [31:0] comp_out
);

always @(negedge clk) begin
    if (reset)
        comp_out <= 32'b0;
    else if (ld_comp)
        comp_out <= {16'b0, r_in};  
    else
        comp_out <= comp_out;
end

endmodule