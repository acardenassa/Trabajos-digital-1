`timescale 1ns / 1ps
`define SIMULATION
module num_divid_TB;

    reg clk;
    reg rst;
    reg sh_1;
    reg add_new_Resi;
    reg [31:0] divid;
    reg [31:0] new_resi;

    wire [31:0] resi_out;
    wire [31:0] sub_a_out;

    num_divid uut (
        .clk(clk),
        .rst(rst),
        .sh_1(sh_1),
        .add_new_Resi(add_new_Resi),
        .divid(divid),
        .new_resi(new_resi),
        .resi_out(resi_out),
        .sub_a_out(sub_a_out)
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
        rst = 0; sh_1 = 0; add_new_Resi = 0;
        divid = 32'd0; new_resi = 32'd0;
        @(posedge clk);

        
        //Activar el rst
        divid = 32'd15; 
        rst = 1;
        @(posedge clk);
        rst = 0;        // Apagamos el reset 
        @(posedge clk);

        //Probamos el desplazamiento
        sh_1 = 1;
        @(posedge clk); // Primer desplazamiento
        @(posedge clk); // Segundo desplazamiento
        sh_1 = 0;       // Apagamos desplazamiento
        @(posedge clk);

        //probamos la función de add_new_Resi
        new_resi = 32'd9;
        add_new_Resi = 1;
        @(posedge clk);
        add_new_Resi = 0; // Apagamos la carga

        #40;
        $finish;
    end
    initial begin: TEST_CASE
       $dumpfile("num_divid_TB.vcd");
       $dumpvars(0, uut);
    end
endmodule