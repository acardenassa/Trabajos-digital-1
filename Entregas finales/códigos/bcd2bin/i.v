module i (

    input clk,
    input ld,
    input resta,
    input [5:0] n,

    output reg [5:0] out_i

);

always @(negedge clk) begin

    if(ld)
        out_i <= n;

    else if(resta)
        out_i <= out_i - 1;

    else
        out_i <= out_i;

end

endmodule