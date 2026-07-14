`timescale 1ns / 1ps
`define SIMULATION

module bin2bcd_TB;

  // Entradas de la caja negra
  reg clk;
  reg rst_hardware;
  reg init;
  reg [6:0] A;

  // Salidas de la caja negra
  wire [3:0] U;
  wire [3:0] D;
  wire done;

  // Instanciación del módulo contenedor
  bin2bcd uut (
      .clk(clk),
      .rst_hardware(rst_hardware),
      .init(init),
      .A(A),
      .U(U),
      .D(D),
      .done(done)
  );

  parameter PERIOD          = 20;
  parameter real DUTY_CYCLE = 0.5;
  parameter OFFSET          = 0;

  // Generador automático de Reloj
  initial begin
    #OFFSET;
    forever begin
        clk = 1'b0;
        #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = 1'b1;
        #(PERIOD*DUTY_CYCLE);
    end
  end

  // Secuencia de estimulación automática
  // Secuencia de estimulación automática (CORREGIDA)
  initial begin
    // 1. Estado de Reset inicial
    #0 rst_hardware = 1; init = 0; A = 7'd0;
    
    // Soltamos el reset en el flanco de bajada
    @(negedge clk);
    rst_hardware = 0;
    
    // 2. Cargar número a convertir (ej. 67 decimal = 1000011 binario)
    @(negedge clk);
    A = 7'd67;  
    init = 1;   // Le damos el pulso de arranque
    
    // Lo soltamos en el siguiente flanco de bajada
    @(negedge clk);
    init = 0;   
    
    // Dejamos que el sistema haga todos los desplazamientos por sí solo.
    wait(done == 1'b1);
    
    // Tiempo para apreciar el resultado (Debe salir D=6 y U=7)
    #(50);

    // 3. Nueva conversión (ej. 45 decimal)
    @(negedge clk);
    A = 7'd45;
    init = 1;
    
    @(negedge clk);
    init = 0;
    
    wait(done == 1'b1);
    
    // Tiempo final
    #(120);
  end

  // Configuración del GTKWave
  initial begin: TEST_CASE
     $dumpfile("bin2bcd_TB.vcd");
     $dumpvars(-1, uut);
     #(2000) $finish; 
  end

endmodule