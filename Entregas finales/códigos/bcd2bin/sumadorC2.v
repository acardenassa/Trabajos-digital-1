module sumadorC2 (
    input [3:0] out_D,
    input [3:0] out_U,
    input new_D,
    input new_U,
    output reg [3:0] out_new_D,
    output reg [3:0] out_new_U
);

always @(*) begin

    if (new_U) begin
        out_new_U = out_U - 4'd3;
    end
    else begin
        out_new_U = out_U;
    end


    if (new_D) begin
        out_new_D = out_D - 4'd3;
    end
    else begin
        out_new_D = out_D;
    end
end

endmodule