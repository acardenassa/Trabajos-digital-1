module num_divisor (
    input [31:0] b,
    input ld,
    input clk,
    output reg [31:0] num_divisor_out);

    always @(negedge clk) begin
        if (ld)
            num_divisor_out <= b;
        else
            num_divisor_out <= num_divisor_out;
    end
endmodule

