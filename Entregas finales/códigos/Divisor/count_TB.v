`timescale 1ns / 1ps
`define SIMULATION

module count_TB;

  reg clk;
  reg ld;
  reg resta;
  reg [5:0] n;

  wire [5:0] out_count;

  count uut(.clk(clk), .ld(ld), .resta(resta), .n(n), .out_count(out_count));

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
    #0 resta=0 ; ld=0; n=4'd4;
    @ (posedge clk);
    ld=1;
    @ (posedge clk);
    ld=0;
    @ (posedge clk);
    resta=1;

  end


  initial begin: TEST_CASE
     $dumpfile("count_TB.vcd");
     $dumpvars(-1, uut);
     #(1000) $finish;
  end
endmodule
