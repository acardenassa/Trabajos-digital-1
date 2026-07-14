`timescale 1ns / 1ps
`define SIMULATION
module reg_R_TB;

reg clk;
reg ld;
reg sh;
reg ro;
wire [15:0] R_out;

reg_R uut(
    .clk(clk),
    .ld(ld),
    .sh(sh),
    .ro(ro),
    .R_out(R_out)
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

//Señales de prueba:
initial begin
    ld=0; sh=0; ro=0;

    
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
    ro=1;
    @(negedge clk); #1;
    ro=0;

  
    @(negedge clk); #1;
    sh=1;
    @(negedge clk); #1;
    sh=0;
end



initial begin: TEST_CASE
$dumpfile("reg_R_TB.vcd");
$dumpvars(-1, uut);
    #(1000) $finish;
end

endmodule