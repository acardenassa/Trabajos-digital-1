module reg_A(
    input clk,
    input ld,
    input sh,
    input  [15:0] a,
    output reg [31:0] A_out
);

always @(negedge clk) begin
    if (ld)
        A_out <= a;   
    else if (sh)
        A_out <= A_out << 1;   
    else
        A_out <= A_out;
end

endmodule