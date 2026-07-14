`timescale 1ns / 1ps
`define SIMULATION
module sum_C2_TB;

reg  [31:0] resi_in;
reg  [31:0] term_in;
wire [31:0] new_resi;
wire SUF;

sum_C2 uut(
    .resi_in(resi_in),
    .term_in(term_in),
    .new_resi(new_resi),
    .SUF(SUF)
);

initial begin
    // Caso 1: resta valida (resi_in >= term_in)
    resi_in = 32'd20;
    term_in = 32'd5;
    #10;
    $display("Caso 1 -> new_resi=%0d  SUF=%b (esperado: 15, SUF=1)", new_resi, SUF);

    // Caso 2: resta invalida (resi_in < term_in)
    resi_in = 32'd3;
    term_in = 32'd5;
    #10;
    $display("Caso 2 -> new_resi=%0d  SUF=%b (esperado: -2, SUF=0)", $signed(new_resi), SUF);

    // Caso 3: resta exacta (resultado = 0, sigue siendo valida)
    resi_in = 32'd8;
    term_in = 32'd8;
    #10;
    $display("Caso 3 -> new_resi=%0d  SUF=%b (esperado: 0, SUF=1)", new_resi, SUF);

    $finish;
end

initial begin: TEST_CASE
$dumpfile("sum_C2_TB.vcd");
$dumpvars(-1, uut);
end

endmodule