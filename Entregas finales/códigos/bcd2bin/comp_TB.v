`timescale 1ns / 1ps
`define SIMULATION
module comp_TB;

reg [3:0] D;
reg [3:0] U;
reg comp_U;
reg comp_D;
wire x1;
wire x2;

comp uut(
    .U(U),
    .D(D),
    .comp_U(comp_U),
    .comp_D(comp_D),
    .x1(x1),
    .x2(x2)
);

initial begin
    
    U = 4'd9; D = 4'd9; comp_U = 0; comp_D = 0;
    #10;
    $display("Caso 1 -> comp_U=%b comp_D=%b U=%0d D=%0d  x1=%b x2=%b (esperado: x1=0 x2=0)", comp_U, comp_D, U, D, x1, x2);

    
    comp_U = 1; comp_D = 0; U = 4'd8; D = 4'd7;
    #10;
    $display("Caso 2 -> comp_U=%b comp_D=%b U=%0d D=%0d  x1=%b x2=%b (esperado: x1=1 x2=0)", comp_U, comp_D, U, D, x1, x2);

   
    comp_U = 0; comp_D = 1; U = 4'd0; D = 4'd9;
    #10;
    $display("Caso 3 -> comp_U=%b comp_D=%b U=%0d D=%0d  x1=%b x2=%b (esperado: x1=0 x2=1)", comp_U, comp_D, U, D, x1, x2);

    
    comp_U = 1; comp_D = 1; U = 4'd9; D = 4'd8;
    #10;
    $display("Caso 4 -> comp_U=%b comp_D=%b U=%0d D=%0d  x1=%b x2=%b (esperado: x1=0 x2=0)", comp_U, comp_D, U, D, x1, x2);

    comp_U = 1; comp_D = 1; U = 4'd5; D = 4'd8;
    #10;

    $finish;
end

initial begin: TEST_CASE
$dumpfile("comp_TB.vcd");
$dumpvars(-1, uut);
end

endmodule