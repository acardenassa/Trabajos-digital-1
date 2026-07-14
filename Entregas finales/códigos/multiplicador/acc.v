module acc(
    input clk,
    input reset,
    input add,
    input  [31:0] A,
    output reg [31:0] R
);

always @(negedge clk) begin
    if (reset)
        R <= 32'b0;
    else if (add)
        R <= R + A;
    else
        R <= R;
end

endmodule