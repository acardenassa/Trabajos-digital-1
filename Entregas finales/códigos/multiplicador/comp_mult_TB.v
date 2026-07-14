`timescale 1ns / 1ps
`define SIMULATION
module comp_mult_TB;

reg [15:0] B;
wire X;

comp_mult uut(
    .B(B),
    .X(X)
);

initial begin
    // Caso 1: B != 0
    B = 16'd6;
    #10;
    $display("Caso 1 -> B=%0d  X=%b (esperado: 0)", B, X);

    // Caso 2: B == 0
    B = 16'd0;
    #10;
    $display("Caso 2 -> B=%0d  X=%b (esperado: 1)", B, X);

    // Caso 3: B = 1 (aun no es cero)
    B = 16'd1;
    #10;
    $display("Caso 3 -> B=%0d  X=%b (esperado: 0)", B, X);

    $finish;
end

initial begin: TEST_CASE
$dumpfile("comp_mult_TB.vcd");
$dumpvars(-1, uut);
end

endmodule