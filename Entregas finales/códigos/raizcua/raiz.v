module raiz(
    input clk,
    input rst_hardware,
    input init,
    input  [31:0] a,          // radicando
    output [15:0] R,          // resultado (raiz), n/2 bits
    output [31:0] resi,       // residuo final
    output done_raiz
);

// 1. CABLES INTERNOS DE CONTROL
wire w_ld;
wire w_sh;
wire w_ro;
wire w_nr;
wire w_ld_comp;
wire w_suf;
wire w_z;

// 2. CABLES INTERNOS DE DATOS
wire [31:0] w_resi_out;
wire [31:0] w_subA_out;
wire [31:0] w_comp_out;
wire [31:0] w_comp_shifted;
wire [31:0] w_new_resi;
wire [5:0]  w_out_count;

// 3. LOGICA DE ACOPLAMIENTO
assign w_z = (w_out_count == 6'd0);
assign w_comp_shifted = (w_comp_out << 1) | 32'b1;   // (Comp<<1)+1
assign resi = w_resi_out;

// 4. CONEXION DE MODULOS
control control_unit (
        .clk(clk),
        .rst_hardware(rst_hardware),
        .init(init),
        .suf(w_suf),
        .z(w_z),
        .ld(w_ld),
        .sh(w_sh),
        .ro(w_ro),
        .nr(w_nr),
        .ld_comp(w_ld_comp),
        .done(done_raiz)
    );

resi_subA reg_resiA (
        .clk(clk),
        .ld(w_ld),
        .sh(w_sh),
        .nr(w_nr),
        .radicando(a),
        .new_resi(w_new_resi),
        .resi_out(w_resi_out),
        .subA_out(w_subA_out)
    );

reg_R reg_resultado (
        .clk(clk),
        .ld(w_ld),
        .sh(w_sh),
        .ro(w_ro),
        .R_out(R)
    );

reg_comp reg_comparador (
        .clk(clk),
        .reset(w_ld),
        .ld_comp(w_ld_comp),
        .r_in(R),
        .comp_out(w_comp_out)
    );

sum_C2 restador (
        .resi_in(w_resi_out),
        .term_in(w_comp_shifted),
        .new_resi(w_new_resi),
        .SUF(w_suf)
    );

count contador (
        .clk(clk),
        .ld(w_ld),
        .resta(w_sh),
        .n(6'd16),
        .out_count(w_out_count)
    );

endmodule