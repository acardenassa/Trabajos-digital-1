`timescale 1ns / 1ps
`define SIMULATION
module reg_comp_TB;

reg clk;
reg reset;
reg ld_comp;
reg [15:0] r_in;
wire [31:0] comp_out;

reg_comp uut(
    .clk(clk),
    .reset(reset),
    .ld_comp(ld_comp),
    .r_in(r_in),
    .comp_out(comp_out)
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
    reset=0; ld_comp=0; r_in=16'd0;

    // Reset inicial
    @(negedge clk); #1;
    reset=1;
    @(negedge clk); #1;
    reset=0;

    //Cargar Comp con R = 5
    r_in = 16'd5;
    @(negedge clk); #1;
    ld_comp=1;
    @(negedge clk); #1;
    ld_comp=0;

    // Cambiar r_in y NO cargar (comp_out no debe cambiar)
    r_in = 16'd99;
    @(negedge clk); #1;

    //Cargar Comp con R = 10
    r_in = 16'd10;
    @(negedge clk); #1;
    ld_comp=1;
    @(negedge clk); #1;
    ld_comp=0;
end



initial begin: TEST_CASE
$dumpfile("reg_comp_TB.vcd");
$dumpvars(-1, uut);
    #(1000) $finish;
end

endmodule