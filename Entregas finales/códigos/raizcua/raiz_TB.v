`timescale 1ns/1ps
module raiz_TB; 
reg clk;
reg rst_hardware;
reg init;
reg [31:0] a;
wire [15:0] R;
wire [31:0] resi;
wire done_raiz;

raiz uut (
        .clk(clk),
        .rst_hardware(rst_hardware),
        .init(init),
        .a(a),
        .R(R),
        .resi(resi),
        .done_raiz(done_raiz)
    );

always #5 clk = ~clk;

initial begin
$dumpfile("raiz_TB.vcd");
$dumpvars(0, raiz_TB);

//estado Inicial
        clk = 0;
        rst_hardware = 1; 
        init = 0;
        a = 32'd0;
#20;              
        rst_hardware = 0; 
#10;

// PRUEBA 1: raiz de 20  (4^2=16, resto=4)
        a = 32'd20;  
        init = 1;         
#10;
        init = 0;        
        @(posedge done_raiz);
#10;
$display("PRUEBA 1 -> raiz(%d) = %d, Residuo: %d", a, R, resi);
#40;

// PRUEBA 2: raiz de 1000000  (1000^2=1000000, resto=0)
#40
        a = 32'd1000000;  
#10
        init = 1;         
#10;
        init = 0;   
              
        @(posedge done_raiz);
#10;
$display("PRUEBA 2 -> raiz(%d) = %d, Residuo: %d", a, R, resi);
#40;

$finish;
end
endmodule