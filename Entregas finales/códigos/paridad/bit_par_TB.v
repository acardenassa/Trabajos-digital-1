`timescale 1ns / 1ps
`define SIMULATION

module bit_par_TB;

reg clk;
reg ld;
reg bit_in;

wire bit_out;

bit_par uut(

    .clk(clk),
    .ld(ld),
    .bit_in(bit_in),
    .bit_out(bit_out)

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

    ld = 0;
    bit_in = 0;

    // Cargar un 0

    @(posedge clk);
    ld = 1;

    @(posedge clk);
    ld = 0;

    // Ahora cargar un 1

    @(posedge clk);
    bit_in = 1;
    ld = 1;

    @(posedge clk);
    ld = 0;

end


initial begin : TEST_CASE

    $dumpfile("bit_par_TB.vcd");
    $dumpvars(-1, uut);

    #200
    $finish;

end

endmodule