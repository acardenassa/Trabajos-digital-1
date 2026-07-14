`timescale 1ns/1ps

module bcd2bin_TB;
reg clk;
reg rst_hardware;
reg init;
reg [3:0] A;
reg [3:0] B;
wire [6:0] num_bin;
wire done;

bcd2bin uut (
        .clk(clk),
        .rst_hardware(rst_hardware),
        .init(init),
        .A(A),
        .B(B),
        .num_bin(num_bin),
        .done(done)
    );

always #5 clk = ~clk;

initial begin
$dumpfile("bcd2bin_TB.vcd");
$dumpvars(0, bcd2bin_TB);

//estado Inicial
        clk = 0;
        rst_hardware = 1;
        init = 0;
        A = 4'd0;
        B = 4'd0;
#20;

        rst_hardware = 0;
#10;

// PRUEBA 1: BCD 45 (A=4, B=5) -> esperado 45 decimal (0101101)
        A = 4'd4;
        B = 4'd5;
        init = 1;
#11;
        init = 0;

        @(posedge done);
#11;
$display("PRUEBA 1 -> BCD %0d%0d = %d (bin: %b)", A, B, num_bin, num_bin);
#41;

// PRUEBA 2: BCD 99 (A=9, B=9) -> esperado 99 decimal (1100011)
        A = 4'd9;
        B = 4'd9;
        init = 1;
#11;
        init = 0;

        @(posedge done);
#11;
$display("PRUEBA 2 -> BCD %0d%0d = %d (bin: %b)", A, B, num_bin, num_bin);
#41;

$finish;
end

endmodule