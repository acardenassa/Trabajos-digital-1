`timescale 1ns / 1ps
`define SIMULATION

module reg_A_TB;

reg clk;
reg ld;
reg sh;
reg [31:0] A_in;

wire [31:0] A_out;

reg_A uut(
    .clk(clk),
    .ld(ld),
    .sh(sh),
    .A_in(A_in),
    .A_out(A_out)
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
    sh = 0;
    A_in = 32'b10110110;

    // Cargar el registro
    @(posedge clk);
    ld = 1;

    @(posedge clk);
    ld = 0;

    // Primer desplazamiento
    @(posedge clk);
    sh = 1;

    // Segundo desplazamiento
    @(posedge clk);

    // Tercer desplazamiento
    @(posedge clk);

    // Cuarto desplazamiento
    @(posedge clk);

    sh = 0;

end

initial begin : TEST_CASE

    $dumpfile("reg_A_TB.vcd");
    $dumpvars(-1, uut);
    $finish;

end

endmodule