`timescale 1ns / 1ps
`define SIMULATION

module resp_TB;

    
    reg clk;
    reg rst;
    reg sh_2;
    reg r0;

    
    wire [31:0] resp_out;

   
    resp uut (
        .clk(clk),
        .rst(rst),
        .sh_2(sh_2),
        .r0(r0),
        .resp_out(resp_out)
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
        
        rst = 0; sh_2 = 0; r0 = 0;
        @(posedge clk);

        //probar el rst
        rst = 1;
        @(posedge clk);
        rst = 0;
        @(posedge clk);

        //El caso donde la resta de positiva
        r0 = 1; sh_2 = 1;
        @(posedge clk);

        // en caso de que la resta de negativa
        r0 = 0; sh_2 = 1;
        @(posedge clk); 

       
        r0 = 1; sh_2 = 1;
        @(posedge clk); 


        r0 = 0; sh_2 = 0;
        @(posedge clk);
        
        #40; 
        $finish;
    end

    // Configuración para GTKWave
    initial begin: TEST_CASE
       $dumpfile("resp_TB.vcd");
       $dumpvars(0, uut);
    end

endmodule