`timescale 1ns / 1ps
`define SIMULATION

module comp_TB;

  
  reg [3:0] U;
  reg [3:0] D;
  reg comp_U;
  reg comp_D;

 
  wire x1;
  wire x2;

  comp uut (
      .U(U), 
      .D(D), 
      .comp_U(comp_U), 
      .comp_D(comp_D), 
      .x1(x1), 
      .x2(x2)
  );

  // Señales de prueba:
  initial begin
   
    #0 
    U = 4'd3; 
    D = 4'd2; 
    comp_U = 0; 
    comp_D = 0;
    
    
    #20 
    U = 4'd6; 
    D = 4'd5; 
    comp_U = 0; 
    comp_D = 0;
    
    
    #20 
    comp_U = 1; 
    comp_D = 0;
    
    
    #20 
    comp_U = 0; 
    comp_D = 1;
    
    
    #20 
    comp_U = 1; 
    comp_D = 1;
    
    
    #20 
    U = 4'd1; 
    D = 4'd4;
  end

  // Generación de archivos para visualizar en GTKWave
  initial begin: TEST_CASE
     $dumpfile("comp_TB.vcd");
     $dumpvars(-1, uut);
     #(140) $finish;
  end

endmodule