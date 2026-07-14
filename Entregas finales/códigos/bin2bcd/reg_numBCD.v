module reg_numBCD(
    input clk,
    input ld,
    input sh,
    input new_U,
    input new_D,
    input  [6:0] A,
    input  [3:0] new_U_val,   
    input  [3:0] new_D_val,   
    output [3:0] D,      // ¡Ojo! Quitamos el 'reg' aquí porque ahora son asignaciones continuas
    output [3:0] U,      // Quitamos el 'reg'
    output [6:0] num     // Quitamos el 'reg'
);

    // 1. Creación del registro gigante de 15 bits
    reg [14:0] num_bcd;

    // 2. Extracción de las salidas (Asignación continua como en tu divisor)
    assign D   = num_bcd[14:11]; // Los 4 bits más altos
    assign U   = num_bcd[10:7];  // Los 4 bits del medio
    assign num = num_bcd[6:0];   // Los 7 bits más bajos

    // 3. Lógica secuencial
    always @(negedge clk) begin
        if (ld) begin
            // Cargamos 8 ceros (para D y U) concatenados con el número A
            num_bcd <= {8'd0, A};
        end
        else if (sh) begin
            // ¡El desplazamiento ahora es súper fácil y en una sola línea!
            num_bcd <= {num_bcd[13:0], 1'b0};
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