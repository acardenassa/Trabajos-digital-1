`timescale 1ns / 1ps
`define SIMULATION

module i_TB;

reg clk;
reg ld;
reg resta;
reg [5:0] n;

wire [5:0] out_i;

i uut(
    .clk(clk),
    .ld(ld),
    .resta(resta),
    .n(n),
    .out_i(out_i)
);

parameter PERIOD = 20;
parameter real DUTY_CYCLE = 0.5;
parameter OFFSET = 0;


// Generación del reloj

initial begin
    #OFFSET;
    forever begin
        clk = 1'b0;
        #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = 1'b1;
        #(PERIOD*DUTY_CYCLE);
    end
end


// Señales de prueba

initial begin

    resta = 0;
    ld = 0;
    n = 6'd8;

    @(posedge clk);
    ld = 1;

    @(posedge clk);
    ld = 0;

    @(posedge clk);
    resta = 1;

    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);

    resta = 0;

end


initial begin : TEST_CASE

    $dumpfile("i_TB.vcd");
    $dumpvars(-1, uut);
    #250 $finish;

end

endmodule