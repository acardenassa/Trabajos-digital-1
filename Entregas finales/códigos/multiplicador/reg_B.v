module reg_B(
    input clk,
    input ld,
    input sh,
    input  [15:0] b,
    output reg [15:0] B_out,
    output LSB_B
);

assign LSB_B = B_out[0];

always @(negedge clk) begin
    if (ld)
        B_out <= b;
    else if (sh)
        B_out <= B_out >> 1;
    else
        B_out <= B_out;
end

endmodule