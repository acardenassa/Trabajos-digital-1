`timescale 1ns / 1ps
`define SIMULATION
module reg_B_TB;

reg clk;
reg ld;
reg sh;
reg [15:0] b;
wire [15:0] B_out;
wire LSB_B;

reg_B uut(
    .clk(clk),
    .ld(ld),
    .sh(sh),
    .b(b),
    .B_out(B_out),
    .LSB_B(LSB_B)
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

//Senales de prueba: cargar b=6 (110), luego 3 shifts
initial begin
    ld=0; sh=0;
    b = 16'd6;

    @(negedge clk); #1;
    ld=1;
    @(negedge clk); #1;
    ld=0;

    @(negedge clk); #1;
    sh=1;
    @(negedge clk); #1;
    sh=0;

    @(negedge clk); #1;
    sh=1;
    @(negedge clk); #1;
    sh=0;

    @(negedge clk); #1;
    sh=1;
    @(negedge clk); #1;
    sh=0;
end



initial begin: TEST_CASE
$dumpfile("reg_B_TB.vcd");
$dumpvars(-1, uut);
    #(1000) $finish;
end

endmodule