module reg_A(
    input clk,
    input rst,
    input ld,
    input sh,
    input [31:0] A_in,

    output reg [31:0] A_out
);

always @(negedge clk) begin

    if(rst)
        A_out <= 0;

    else if(ld)
        A_out <= A_in;

    else if(sh)
        A_out <= A_out >> 1;

end

endmodule