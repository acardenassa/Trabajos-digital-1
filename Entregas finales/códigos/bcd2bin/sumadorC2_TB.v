`timescale 1ns / 1ps
`define SIMULATION
module sumadorC2_TB;

reg [3:0] out_D;
reg [3:0] out_U;
reg new_D;
reg new_U;
wire [3:0] out_new_D;
wire [3:0] out_new_U;

sumadorC2 uut(
    .out_D(out_D),
    .out_U(out_U),
    .new_D(new_D),
    .new_U(new_U),
    .out_new_D(out_new_D),
    .out_new_U(out_new_U)
);

initial begin
    // Caso 1: new_U=0, new_D=0 -> deben pasar los valores tal cual (sin restar)
    out_U = 4'd9; out_D = 4'd9; new_U = 0; new_D = 0;
    #10;
    $display("Caso 1 -> out_U=%0d out_D=%0d new_U=%b new_D=%b  out_new_U=%0d out_new_D=%0d (esperado: 9, 9)", out_U, out_D, new_U, new_D, out_new_U, out_new_D);

    // Caso 2: new_U=1, out_U=9 -> out_new_U = 9-3 = 6
    new_U = 1; new_D = 0; out_U = 4'd9; out_D = 4'd7;
    #10;
    $display("Caso 2 -> out_U=%0d new_U=%b  out_new_U=%0d (esperado: 6)", out_U, new_U, out_new_U);

    // Caso 3: new_D=1, out_D=9 -> out_new_D = 9-3 = 6
    new_U = 0; new_D = 1; out_U = 4'd0; out_D = 4'd9;
    #10;
    $display("Caso 3 -> out_D=%0d new_D=%b  out_new_D=%0d (esperado: 6)", out_D, new_D, out_new_D);

    // Caso 4: ambos activos a la vez
    new_U = 1; new_D = 1; out_U = 4'd8; out_D = 4'd8;
    #10;
    $display("Caso 4 -> out_U=%0d out_D=%0d  out_new_U=%0d out_new_D=%0d (esperado: 5, 5)", out_U, out_D, out_new_U, out_new_D);

    $finish;
end

initial begin: TEST_CASE
$dumpfile("sumadorC2_TB.vcd");
$dumpvars(-1, uut);
end

endmodule