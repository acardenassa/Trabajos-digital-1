module comp2(
    input [6:0] num, 
    output reg z     
);

always @(*) begin
    if (num == 7'b0) begin
        z = 1'b1; 
    end
    else begin
        z = 1'b0; 
    end
end

endmodule