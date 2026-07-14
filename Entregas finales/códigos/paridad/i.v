module i (

    input clk,
    input ld,
    input resta,


    output reg [5:0] out_i

);

always @(negedge clk) begin

    if(ld)
        out_i <= 6'd32;

    else if(resta)
        out_i <= out_i - 1;

    else
        out_i <= out_i;

end

endmodule