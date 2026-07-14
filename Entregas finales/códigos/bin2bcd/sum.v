module sum(
    input [3:0] U,
    input [3:0] D,
    input R_U,  
    input R_D,  
    output reg [3:0] out_new_U,
    output reg [3:0] out_new_D
);

always @(*) begin
   
    if (R_U) begin
        out_new_U = U + 4'd3;
    end
    else begin
        out_new_U = U;
    end

   
    if (R_D) begin
        out_new_D = D + 4'd3;
    end
    else begin
        out_new_D = D;
    end
end

endmodule