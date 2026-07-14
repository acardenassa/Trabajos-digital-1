`timescale 1ns / 1ps
`define SIMULATION
module val_error_TB;

reg [3:0] A;
reg [3:0] B;
wire Error;

val_error uut(
    .A(A),
    .B(B),
    .Error(Error)
);

initial begin
    
    A = 4'd1; B = 4'd3;
    #10;
    $display("Caso 1 -> A=%b B=%b Error=%b (esperado: 0)", A, B, Error);

    
    A = 4'd9; B = 4'd9;
    #10;
    $display("Caso 2 -> A=%b B=%b Error=%b (esperado: 0)", A, B, Error);


    A = 4'b1010; B = 4'd0;
    #10;
    $display("Caso 3 -> A=%b B=%b Error=%b (esperado: 1)", A, B, Error);

   
    A = 4'd0; B = 4'b1111;
    #10;
    $display("Caso 4 -> A=%b B=%b Error=%b (esperado: 1)", A, B, Error);


    A = 4'd8; B = 4'd0;
    #10;
    $display("Caso 5 -> A=%b B=%b Error=%b (esperado: 0)", A, B, Error);

    $finish;
end

initial begin: TEST_CASE
$dumpfile("val_error_TB.vcd");
$dumpvars(-1, uut);
end

endmodule