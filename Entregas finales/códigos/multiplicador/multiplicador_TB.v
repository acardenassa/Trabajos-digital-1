`timescale 1ns/1ps

module multiplicador_TB;
reg clk;
reg rst_hardware;
reg init;
reg [15:0] multiplicando;
reg [15:0] multiplicador;
wire [31:0] R;
wire done;

multiplicador uut (
        .clk(clk),
        .rst_hardware(rst_hardware),
        .init(init),
        .multiplicando(multiplicando),
        .multiplicador(multiplicador),
        .R(R),
        .done(done)
    );

always #5 clk = ~clk;

initial begin
$dumpfile("multiplicador_TB.vcd");
$dumpvars(0, multiplicador_TB);

//estado Inicial
        clk = 0;
        rst_hardware = 1;
        init = 0;
        multiplicando = 16'd0;
        multiplicador = 16'd0;
#20;

        rst_hardware = 0;
#10;

// PRUEBA 1: 5 x 6 = 30
        multiplicando = 16'd5;
        multiplicador = 16'd6;
        init = 1;
#11;
        init = 0;

        @(posedge done);
#11;
$display("PRUEBA 1 -> %d x %d = %d", multiplicando, multiplicador, R);
#41;

// PRUEBA 2: 12 x 11 = 132
        multiplicando = 16'd12;
        multiplicador = 16'd11;
        init = 1;
#11;
        init = 0;

        @(posedge done);
#11;
$display("PRUEBA 2 -> %d x %d = %d", multiplicando, multiplicador, R);
#41;

$finish;
end

endmodule