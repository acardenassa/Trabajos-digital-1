module bin2bcd(
    input clk,
    input rst_hardware,
    input init,
    input [6:0] A,
    output [3:0] U,
    output [3:0] D,
    output done
);

    // ==========================================
    // 1. CABLES INTERNOS DE CONTROL
    // ==========================================
    wire w_ld;
    wire w_sh;
    wire w_new_U;
    wire w_new_D;
    wire w_comp_U;
    wire w_comp_D;
    wire w_x1;
    wire w_x2;
    wire w_z;

    // ==========================================
    // 2. CABLES INTERNOS DE DATOS
    // ==========================================
    wire [3:0] w_new_U_val;
    wire [3:0] w_new_D_val;
    wire [6:0] w_num;

    // ==========================================
    // 3. LÓGICA DE ACOPLAMIENTO
    // ==========================================
    // (En este caso particular, las salidas U y D 
    // se conectan directamente a los puertos del registro, 
    // así que no necesitamos assigns extra).

    // ==========================================
    // 4. CONEXIÓN DE MÓDULOS
    // ==========================================

    // Unidad de Control (FSM)
    control control_unit (
        .clk(clk),
        .rst_hardware(rst_hardware),
        .init(init),
        .x1(w_x1),
        .x2(w_x2),
        .z(w_z),
        .ld(w_ld),
        .sh(w_sh),
        .new_U(w_new_U),
        .new_D(w_new_D),
        .comp_U(w_comp_U),
        .comp_D(w_comp_D),
        .done(done)
    );

    // Registro Principal BCD
    reg_numBCD datapath_reg (
        .clk(clk),
        .ld(w_ld),
        .sh(w_sh),
        .new_U(w_new_U),
        .new_D(w_new_D),
        .A(A),
        .new_U_val(w_new_U_val),
        .new_D_val(w_new_D_val),
        .D(D),     // Conexión directa a la salida del módulo general
        .U(U),     // Conexión directa a la salida del módulo general
        .num(w_num)
    );

    // Sumador Combinacional
    sum sumador (
        .U(U),
        .D(D),
        .R_U(w_new_U),
        .R_D(w_new_D),
        .out_new_U(w_new_U_val),
        .out_new_D(w_new_D_val)
    );

    // Comparador Combinacional (>= 5)
    comp comparador_5 (
        .U(U),
        .D(D),
        .comp_U(w_comp_U),
        .comp_D(w_comp_D),
        .x1(w_x1),
        .x2(w_x2)
    );

    // Comparador de Cero
    comp2 comparador_z (
        .num(w_num),
        .z(w_z)
    );

endmodule