`timescale 1ns/1ps

module paridad_TB;

    reg clk;
    reg rst;
    reg init;
    reg [31:0] A_in;

    wire bit_out;
    wire done;


    paridad uut(

        .clk(clk),
        .rst(rst),
        .init(init),
        .A_in(A_in),

        .bit_out(bit_out),
        .done(done)

    );



    // Generación del reloj


    always #10 clk = ~clk;



    // Pruebas


    initial begin

        $dumpfile("paridad_TB.vcd");
        $dumpvars(0, paridad_TB);

        clk = 0;
        rst=1;
        init = 0;
        A_in = 0;

        #20;
        rst=0;
        #20;
        // PRUEBA 1

        A_in = 32'd13;

        init = 1;
        #20;
        init = 0;

        @(posedge done);

        #40;


        $display("PRUEBA 1");
        $display("Numero = %d",A_in);
        $display("Bit de paridad = %d",bit_out);

        #100;

        // PRUEBA 2

        A_in = 32'd10;

        init = 1;
        #20;
        init = 0;

        @(posedge done);

        #40;

        $display("PRUEBA 2");
        $display("Numero = %d",A_in);
        $display("Bit de paridad = %d",bit_out);

        #40;

        $finish;

    end

endmodule