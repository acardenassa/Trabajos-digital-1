`timescale 1ns / 1ps
`define SIMULATION

module sum_TB;

  reg [3:0] U;
  reg [3:0] D;
  reg R_U;
  reg R_D;

  wire [3:0] out_new_U;
  wire [3:0] out_new_D;

  sum uut (
      .U(U), 
      .D(D), 
      .R_U(R_U), 
      .R_D(R_D), 
      .out_new_U(out_new_U), 
      .out_new_D(out_new_D)
  );

  // Señales de prueba:
  initial begin
    
    #0 
    U = 4'd5; 
    D = 4'd6; 
    R_U = 0; 
    R_D = 0;
    
    #20 
    R_U = 1; 
    R_D = 0;
    
    
    #20 
    R_U = 0; 
    R_D = 1;
    
    #20 
    R_U = 1; 
    R_D = 1;
    
    
    #20 
    U = 4'd7; 
    D = 4'd8; 
  end

  // Generación de archivos para visualizar en GTKWave
  initial begin: TEST_CASE
     $dumpfile("sum_TB.vcd");
     $dumpvars(-1, uut);
     #(120) $finish;
  end

endmodule