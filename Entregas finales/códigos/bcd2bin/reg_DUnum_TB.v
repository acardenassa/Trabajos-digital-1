`timescale 1ns / 1ps
`define SIMULATION
module reg_DUnum_TB;

reg clk;
reg ld;
reg sh;
reg new_U;
reg new_D;
reg [3:0] A;
reg [3:0] B;
reg [3:0] new_U_val;
reg [3:0] new_D_val;
wire [3:0] D;
wire [3:0] U;
wire [6:0] num;

reg_DUnum uut(
    .clk(clk),
    .ld(ld),
    .sh(sh),
    .new_U(new_U),
    .new_D(new_D),
    .A(A),
    .B(B),
    .new_U_val(new_U_val),
    .new_D_val(new_D_val),
    .D(D),
    .U(U),
    .num(num)
);

parameter PERIOD          = 20;
parameter real DUTY_CYCLE = 0.5;
parameter OFFSET          = 0;

initial  begin  // Generacion del reloj automatico
    #OFFSET;
    forever
    begin
        clk = 1'b0;
        #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = 1'b1;
        #(PERIOD*DUTY_CYCLE);
    end
end

//Senales de prueba: convertir BCD 13 (D=1, U=3) -> esperado num final = 0001101 (13 decimal)
initial begin
    ld=0; sh=0; new_U=0; new_D=0;
    A = 4'd1;  // decenas
    B = 4'd3;  // unidades
    new_U_val = 4'd0;
    new_D_val = 4'd0;

    // 1. Carga inicial
    @(negedge clk); #1;
    ld=1;
    @(negedge clk); #1;
    ld=0;

    // 2. Shift x3
    @(negedge clk); #1;
    sh=1;
    @(negedge clk); #1;
    sh=0;

    @(negedge clk); #1;
    sh=1;
    @(negedge clk); #1;
    sh=0;

    @(negedge clk); #1;
    sh=1;
    @(negedge clk); #1;
    sh=0;

    // 3. Probar correccion new_U (forzar U-3, valor de ejemplo)
    new_U_val = 4'd5;
    @(negedge clk); #1;
    new_U=1;
    @(negedge clk); #1;
    new_U=0;

    // 4. Probar correccion new_D (forzar D-3, valor de ejemplo)
    new_D_val = 4'd2;
    @(negedge clk); #1;
    new_D=1;
    @(negedge clk); #1;
    new_D=0;

    // 5. Shift final
    @(negedge clk); #1;
    sh=1;
    @(negedge clk); #1;
    sh=0;
end

// Debug
initial begin
    $display("  tiempo | ld sh new_U new_D | D    U    num");
    forever begin
        @(posedge clk);
        #1;
        $display("%8t |  %b  %b   %b     %b   | %b %b %b", $time, ld, sh, new_U, new_D, D, U, num);
    end
end

initial begin: TEST_CASE
$dumpfile("reg_DUnum_TB.vcd");
$dumpvars(-1, uut);
    #(1000) $finish;
end

endmodule