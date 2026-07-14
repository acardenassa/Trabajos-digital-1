`timescale 1ns / 1ps
`define SIMULATION

module count_TB;

reg clk;
reg ld;
reg sum;
reg bit_A;

wire [5:0] out_count;

count uut(

    .clk(clk),
    .ld(ld),
    .sum(sum),
    .bit_A(bit_A),
    .out_count(out_count)

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


// Pruebas

initial begin

    ld = 0;
    sum = 0;
    bit_A = 0;

    // Inicializar contador

    @(posedge clk);
    ld = 1;

    @(posedge clk);
    ld = 0;

    // +1

    bit_A = 1;
    sum = 1;
    @(posedge clk);

    // +0

    bit_A = 0;
    @(posedge clk);

    // +1

    bit_A = 1;
    @(posedge clk);

    // +1

    bit_A = 1;
    @(posedge clk);

    // +0

    bit_A = 0;
    @(posedge clk);

    sum = 0;

end


initial begin : TEST_CASE

    $dumpfile("count_TB.vcd");
    $dumpvars(-1, uut);

    #250 $finish;

end

endmodule