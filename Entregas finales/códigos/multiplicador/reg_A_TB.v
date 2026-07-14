`timescale 1ns / 1ps
`define SIMULATION
module reg_A_TB;

reg clk;
reg ld;
reg sh;
reg [15:0] a;
wire [31:0] A_out;

reg_A uut(
    .clk(clk),
    .ld(ld),
    .sh(sh),
    .a(a),
    .A_out(A_out)
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

//Senales de prueba: cargar a=5, luego 3 shifts
initial begin
    ld=0; sh=0;
    a = 16'd5;

    @(negedge clk); #1;
    ld=1;
    @(negedge clk); #1;
    ld=0;

    @(negedge clk); #1;
    sh=1;
    @(negedge clk); #1;
    @(negedge clk); #1;
    sh=0;
end



initial begin: TEST_CASE
$dumpfile("reg_A_TB.vcd");
$dumpvars(-1, uut);
    #(1000) $finish;
end

endmodule