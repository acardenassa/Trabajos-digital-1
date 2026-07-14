module reg_R(
    input clk,
    input ld,               
    input sh,               
    input ro,               
    output reg [15:0] R_out  
);

always @(negedge clk) begin
    if (ld)
        R_out <= 16'b0;
    else if (sh)
        R_out <= R_out << 1;
    else if (ro)
        R_out[0] <= 1'b1;
    else
        R_out <= R_out;
end

endmodule