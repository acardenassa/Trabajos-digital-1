module multiplicador(
    input clk,
    input rst_hardware,
    input init,
    input  [15:0] multiplicando,
    input  [15:0] multiplicador,
    output [31:0] R,
    output done
);

// 1. CABLES INTERNOS DE CONTROL
wire w_sh;
wire w_reset;
wire w_add;
wire w_lsbb;
wire w_x;

// 2. CABLES INTERNOS DE DATOS
wire [31:0] w_A;
wire [15:0] w_B;

// 3. CONEXION DE MODULOS
control control_unit (
    .clk(clk),
    .rst_hardware(rst_hardware),
    .init(init),
    .lsbb(w_lsbb),
    .x(w_x),
    .sh(w_sh),
    .reset(w_reset),
    .add(w_add),
    .done(done)
);

reg_A reg_multiplicando (
    .clk(clk),
    .ld(w_reset),
    .sh(w_sh),
    .a(multiplicando),
    .A_out(w_A)
);

reg_B reg_multiplicador (
    .clk(clk),
    .ld(w_reset),
    .sh(w_sh),
    .b(multiplicador),
    .B_out(w_B),
    .LSB_B(w_lsbb)
);

acc acumulador (
    .clk(clk),
    .reset(w_reset),
    .add(w_add),
    .A(w_A),
    .R(R)
);

comp_mult comparador (
    .B(w_B),
    .X(w_x)
);

endmodule