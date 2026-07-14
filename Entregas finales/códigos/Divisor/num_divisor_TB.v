`timescale 1ns / 1ps
`define SIMULATION

module num_divisor_TB;

 
  reg clk;
  reg [31:0] b;
  reg ld;


  wire [31:0] num_divisor_out;


  num_divisor uut (
      .clk(clk),
      .b(b),
      .ld(ld),
      .num_divisor_out(num_divisor_out)
  );


  parameter PERIOD          = 20;
  parameter real DUTY_CYCLE = 0.5;
  parameter OFFSET          = 0;

  // Generador de Reloj Automático
  initial begin
     #OFFSET;
     forever begin
         clk = 1'b0;
         #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = 1'b1;
         #(PERIOD*DUTY_CYCLE);
     end
  end

 
  initial begin
    // Estado inicial
    ld = 0;
    b = 32'd0;
    
    @(posedge clk); 
    b = 32'd54321; 
    ld = 0;
    
    @(posedge clk);
    
    ld = 1;
    
    @(posedge clk);
    
    ld = 0;
    b = 32'd99999; 
    
    @(posedge clk);
    #20; 
    
    $finish; // Terminar simulación
  end

  // Configuración para GTKWave
  initial begin: TEST_CASE
     $dumpfile("num_divisor_TB.vcd");
     $dumpvars(0, uut);
     #(1000) $finish;
  end

endmodule