`timescale 1ns / 1ps
`define SIMULATION
module acc_TB;

reg clk;
reg reset;
reg add;
reg [31:0] A;
wire [31:0] R;

acc uut(
    .clk(clk),
    .reset(reset),
    .add(add),
    .A(A),
    .R(R)
);

parameter PERIOD          = 20;
parameter real DUTY_CYCLE = 0.5;
parameter OFFSET          = 0;

initial  begin
    #OFFSET;
    forever
    begin
        clk = 1'b0;
        #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = 1'b1;
        #(PERIOD*DUTY_CYCLE);
    end
end

//Senales de prueba: reset, luego sumar 5 tres veces (R: 0->5->10->15)
initial begin
    reset=0; add=0;
    A = 32'd5;

    @(negedge clk); #1;
    reset=1;
    @(negedge clk); #1;
    reset=0;

    @(negedge clk); #1;
    add=1;
    @(negedge clk); #1;
    @(negedge clk); #1;
    add=0;

    // Cambiar A y sumar de nuevo (R: 15 -> 15+8=23)
    A = 32'd8;
    @(negedge clk); #1;
    add=1;
    @(negedge clk); #1;
    add=0;
end



initial begin: TEST_CASE
$dumpfile("acc_TB.vcd");
$dumpvars(-1, uut);
    #(1000) $finish;
end

endmodule