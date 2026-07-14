`timescale 1ns / 1ps
`define SIMULATION

module comp2_TB;

  reg [6:0] num;
  wire z;

  comp2 uut (
      .num(num),
      .z(z)
  );

  // Señales de prueba:
  initial begin
    
    #0 
    num = 7'd6;
    
    #20 
    num = 7'd1;
    
    #20 num = 7'd0;
    
    #20 num = 7'b0000000;
  end

  // Generación de archivos para visualizar en GTKWave
  initial begin: TEST_CASE
     $dumpfile("comp2_TB.vcd");
     $dumpvars(-1, uut);
     #(120) $finish;
  end

endmodule