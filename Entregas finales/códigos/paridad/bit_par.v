module bit_par(

    input clk,
    input rst,
    input ld,
    input bit_in,

    output reg bit_out

);

always @(negedge clk) begin

    if(rst)
        bit_out <= 1'b0;

    else if(ld)
        bit_out <= bit_in;

    else
        bit_out <= bit_out;

end

endmodule