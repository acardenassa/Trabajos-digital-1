module comp(
    input [3:0] U,
    input [3:0] D,
    input comp_U, 
    input comp_D, 
    output reg x1, //unidades
    output reg x2  //decenas
);

always @(*) begin
    // Lógica para evaluar las Unidades
    if (comp_U) begin
        x1 = (U >= 4'd5) ? 1'b1 : 1'b0;
    end
    else begin
        x1 = 1'b0;
    end

    // Lógica para evaluar las Decenas
    if (comp_D) begin
        x2 = (D >= 4'd5) ? 1'b1 : 1'b0;
    end
    else begin
        x2 = 1'b0; 
    end
end

endmodule