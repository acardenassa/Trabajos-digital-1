module count(

    input clk,
    input ld,
    input rst,
    input sum,
    input bit_A,

    output reg [5:0] out_count

);

always @(negedge clk) begin

    if(ld)
        out_count <= 6'd0;


    else if(sum)
        out_count <= out_count + bit_A;

    else
        out_count <= out_count;

end

endmodule