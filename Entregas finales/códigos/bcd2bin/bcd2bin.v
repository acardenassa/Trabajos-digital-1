module bcd2bin(
    input clk,
    input rst_hardware,
    input init,
    input  [3:0] A,        // decenas (BCD)
    input  [3:0] B,        // unidades (BCD)
    output [6:0] num_bin,  // resultado binario
    output done
);

// 1. CABLES INTERNOS DE CONTROL
wire w_ld;
wire w_sh;
wire w_comp_U;
wire w_comp_D;
wire w_new_U;
wire w_new_D;
wire w_x1;
wire w_x2;
wire w_z;
wire w_error;

// 2. CABLES INTERNOS DE DATOS
wire [3:0] w_D;
wire [3:0] w_U;
wire [3:0] w_new_U_val;
wire [3:0] w_new_D_val;
wire [5:0] w_out_count;

// 3. LOGICA DE ACOPLAMIENTO
assign w_z = (w_out_count == 6'd0);

// 4. CONEXION DE MODULOS
control control_unit (
    .clk(clk),
    .rst_hardware(rst_hardware),
    .init(init),
    .error(w_error),
    .x1(w_x1),
    .x2(w_x2),
    .z(w_z),
    .ld(w_ld),
    .sh(w_sh),
    .comp_U(w_comp_U),
    .comp_D(w_comp_D),
    .new_U(w_new_U),
    .new_D(w_new_D),
    .done(done)
);

reg_DUnum reg_datos (
    .clk(clk),
    .ld(w_ld),
    .sh(w_sh),
    .new_U(w_new_U),
    .new_D(w_new_D),
    .A(A),
    .B(B),
    .new_U_val(w_new_U_val),
    .new_D_val(w_new_D_val),
    .D(w_D),
    .U(w_U),
    .num(num_bin)
);

comp comparador (
    .U(w_U),
    .D(w_D),
    .comp_U(w_comp_U),
    .comp_D(w_comp_D),
    .x1(w_x1),
    .x2(w_x2)
);

sumadorC2 restador (
    .out_D(w_D),
    .out_U(w_U),
    .new_D(w_new_D),
    .new_U(w_new_U),
    .out_new_D(w_new_D_val),
    .out_new_U(w_new_U_val)
);

val_error validador (
    .A(A),
    .B(B),
    .Error(w_error)
);

i contador (
    .clk(clk),
    .ld(w_ld),
    .resta(w_sh),
    .n(6'd7),
    .out_i(w_out_count)
);

endmodule