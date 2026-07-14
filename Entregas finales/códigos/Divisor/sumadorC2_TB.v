`timescale 1ns / 1ps
`define SIMULATION

module sumadorC2_TB;

    reg [31:0] resi_in; //a los que yo les doy valores son los reg y las salidas son los wire
    reg [31:0] b_in;
    wire [31:0] new_resi;
    wire comp;

    sumadorC2 uut (
        .resi_in(resi_in), 
        .b_in(b_in),
        .new_resi(new_resi),
        .comp(comp)
    );


//Señales de prueba:

    initial begin
        resi_in=32'd0;
        b_in=32'd0; 
        #10 

        resi_in=32'd3;
        b_in=32'd10;
        #10

        resi_in=32'd10;
        b_in=32'd4;
        #10

        $finish;

    end


  initial begin: TEST_CASE
     $dumpfile("sumadorC2_TB.vcd");
     $dumpvars(-1, uut);
     #(1000) $finish;
  end
endmodule
