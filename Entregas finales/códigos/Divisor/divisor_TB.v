`timescale 1ns/1ps

module divisor_TB; 
   
    reg clk;
    reg rst_hardware;
    reg init;
    reg [31:0] divida;
    reg [31:0] divisb;
    
    wire [31:0] res_div;
    wire [31:0] resi;
    wire done_div;

    
    divisor uut (
        .clk(clk),
        .rst_hardware(rst_hardware),
        .init(init),
        .divida(divida),
        .divisb(divisb),
        .res_div(res_div),
        .resi(resi),
        .done_div(done_div)
    );

   
    always #5 clk = ~clk;

    
    initial begin
        
        $dumpfile("divisor_TB.vcd");
        $dumpvars(0, divisor_TB);

        //estado Inicial
        clk = 0;
        rst_hardware = 1; 
        init = 0;
        divida = 32'd0;
        divisb = 32'd0;
        #20;              

        rst_hardware = 0; 
        #10;

        // PRUEBA 1: 20 dividido entre 4
    
        divida = 32'd20;  
        divisb = 32'd4;   
        init = 1;         
        #11;
        init = 0;        

       
        @(posedge done_div);
        #11;
        $display("PRUEBA 1 -> %d / %d = Cociente: %d, Residuo: %d", divida, divisb, res_div, resi);
        #41;

        // PRUEBA 2: 45 dividido entre 6
        divida = 32'd45;  
        divisb = 32'd6;   
        init = 1;         
#11;
        init = 0;         

        @(posedge done_div);
#11;
$display("PRUEBA 2 -> %d / %d = Cociente: %d, Residuo: %d", divida, divisb, res_div, resi);
#41;


        
        $finish;
    end

endmodule