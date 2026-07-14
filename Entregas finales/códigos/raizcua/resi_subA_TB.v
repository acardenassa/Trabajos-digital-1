`timescale 1ns / 1ps
`define SIMULATION
module resi_subA_TB;

reg clk;
reg ld;
reg sh;
reg nr; //new resi
reg  [31:0] radicando;
reg  [31:0] new_resi;
wire [31:0] resi_out;
wire [31:0] subA_out;

resi_subA uut(
    .clk(clk),
    .ld(ld),
    .sh(sh),
    .nr(nr),
    .radicando(radicando),
    .new_resi(new_resi),
    .resi_out(resi_out),
    .subA_out(subA_out)
);

parameter PERIOD          = 20;
parameter real DUTY_CYCLE = 0.5;
parameter OFFSET          = 0;

initial  begin  // Generación del reloj automático
    #OFFSET;
    forever
    begin
        clk = 1'b0;
        #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = 1'b1;
        #(PERIOD*DUTY_CYCLE);
    end
end

//Señales de prueba:
initial begin
    ld=0; sh=0; nr=0;
    radicando = 32'd1000000;
    new_resi  = 32'd255;

    @(negedge clk); #1;
    ld=1;
    @(negedge clk); #1;
    ld=0;

    @(negedge clk); #1;
    sh=1;
    @(negedge clk); #1;
    @(negedge clk); #1;
    sh=0;

    @(negedge clk); #1;
    nr=1;
    @(negedge clk); #1;
    nr=0;
end


initial begin: TEST_CASE
    $dumpfile("resi_subA_TB.vcd");
    $dumpvars(-1, uut);
    #(1000) $finish;
end

endmodule