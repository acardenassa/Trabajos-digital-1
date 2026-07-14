module reg_DUnum(
    input clk,
    input ld,
    input sh,
    input new_U,
    input new_D,
    input  [3:0] A,           // decenas (BCD)
    input  [3:0] B,           // unidades (BCD)
    input  [3:0] new_U_val,   // viene de sum_C2 (U-3)
    input  [3:0] new_D_val,   // viene de sum_C2 (D-3)
    output [3:0] D,
    output [3:0] U,
    output [6:0] num
);
    // 1. Creacion del registro gigante de 15 bits
    reg [14:0] num_bcd;

    // 2. Extraccion de las salidas (asignacion continua)
    assign D   = num_bcd[14:11]; // Los 4 bits mas altos
    assign U   = num_bcd[10:7];  // Los 4 bits del medio
    assign num = num_bcd[6:0];   // Los 7 bits mas bajos

    // 3. Logica secuencial
    always @(negedge clk) begin
        if (ld) begin
            // Cargamos A y B en D y U, y 7 ceros en num
            num_bcd <= {A, B, 7'd0};
        end
        else if (sh) begin
            // Shift a la DERECHA, entra un 0 por el bit mas alto
            num_bcd <= {1'b0, num_bcd[14:1]};
        end
        else begin
            // Sobreescritura parcial directa en los "cajones" correspondientes
            if (new_U) begin
                num_bcd[10:7] <= new_U_val;
            end
            if (new_D) begin
                num_bcd[14:11] <= new_D_val;
            end
        end
    end
endmodule