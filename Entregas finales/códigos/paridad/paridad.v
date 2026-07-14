module paridad(

    input clk,
    input rst,
    input init,
    input [31:0] A_in,

    output bit_out,
    output done

);

//======================================
// Señales internas
//======================================

wire [31:0] w_A;
wire [5:0]  w_count;
wire [5:0]  w_i;

wire ld;
wire sum;
wire pari;

wire x;


//======================================
// Señal de fin de iteraciones
//======================================

assign x = (w_i == 6'd0);


//======================================
// Registro A
//======================================

reg_A registro_A(

    .clk(clk),
    .rst(rst),
    .ld(ld),
    .sh(sum),
    .A_in(A_in),
    .A_out(w_A)

);


//======================================
// Contador de unos
//======================================

count contador(

    .clk(clk),
    .ld(ld),
    .sum(sum),
    .bit_A(w_A[0]),
    .out_count(w_count)

);


//======================================
// Contador de iteraciones
//======================================

i contador_i(

    .clk(clk),
    .ld(ld),
    .resta(sum),
    .out_i(w_i)

);


//======================================
// Registro del bit de paridad
//======================================

bit_par registro_paridad(

    .clk(clk),
    .rst(rst),
    .ld(pari),
    .bit_in(w_count[0]),
    .bit_out(bit_out)

);


//======================================
// Máquina de control
//======================================

control controlador(

    .clk(clk),
    .rst(rst),
    .init(init),
    .x(x),                  // <-- CORREGIDO
    .lsb_count(w_count[0]),

    .ld(ld),
    .sum(sum),
    .done(done),
    .pari(pari)

);

endmodule