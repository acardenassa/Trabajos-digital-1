`timescale 1ns / 1ps
`define SIMULATION

module reg_numBCD_TB;

  // Declaración de registros para estimular las entradas
  reg clk;
  reg ld;
  reg sh;
  reg new_U;
  reg new_D;
  reg [6:0] A;
  reg [3:0] new_U_val;
  reg [3:0] new_D_val;

  
  wire [3:0] D;
  wire [3:0] U;
  wire [6:0] num;

  
  reg_numBCD uut (
      .clk(clk),
      .ld(ld),
      .sh(sh),
      .new_U(new_U),
      .new_D(new_D),
      .A(A),
      .new_U_val(new_U_val),
      .new_D_val(new_D_val),
      .D(D),
      .U(U),
      .num(num)
  );

  parameter PERIOD          = 20;
  parameter real DUTY_CYCLE = 0.5;
  parameter OFFSET          = 0;

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
    
    #0 
    ld = 0; 
    sh = 0; 
    new_U = 0; 
    new_D = 0; 
    A= 7'b0; 
    new_U_val = 4'b0; 
    new_D_val = 4'b0;
    
    
    @(posedge clk);
    
    A  = 7'b1000011;
    ld = 1;
    
    @(posedge clk);
    ld = 0;
    sh = 1;
    
    @(posedge clk);
    
    
    @(posedge clk);
    sh = 0;
    new_U_val = 4'd8;
    new_U     = 1;
    new_D_val = 4'd5;
    new_D     = 1;
    
    @(posedge clk);
    new_U     = 0; 
    new_D     = 0; 
    sh=1;
  
    
    @(posedge clk);

    sh=0;
    
    @(posedge clk);
    @(posedge clk);
  end

  // Generación de archivos para visualizar en GTKWave
  initial begin: TEST_CASE
     $dumpfile("reg_numBCD_TB.vcd");
     $dumpvars(-1, uut);
     #(300) $finish; // Tiempo suficiente para analizar el comportamiento completo
  end

endmodule