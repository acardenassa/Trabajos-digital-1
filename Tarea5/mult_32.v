// --- CAJA PRINCIPAL DEL CAMINO DE DATOS ---
module mult_32(clk, rst, init, A, B, pp, done);
    input rst;
    input clk;
    input init;
    input [15:0] A;
    input [15:0] B;
    output [31:0] pp;        // Resultado final
    output done;

    wire w_sh;
    wire w_reset;
    wire w_add;
    wire w_z;

    wire [31:0] w_A;
    wire [15:0] w_B;

    // Conectamos las piezas internas
    rsr  rsr0  (.clk(clk), .in_B(B), .shift(w_sh), .load(w_reset), .s_B(w_B));
    lsr  lsr0  (.clk(clk), .in_A(A), .shift(w_sh), .load(w_reset), .s_A(w_A));
    comp comp0 (.B(w_B), .z(z));
    acc  acc0  (.clk(clk), .A(w_A), .add(w_add), .rst(w_reset), .pp(pp));
    control_mult control0 (.clk(clk),.rst(rst),.lsb_B(w_B[0]),.init(init),.z(w_z),.done(done),.sh(w_sh),.reset(w_reset),.add(w_add));
endmodule

// --- PIEZAS INTERNAS (Del libro del profe) ---
module rsr(clk, in_B, shift, load, s_B);
  input clk;
  input [15:0]in_B;
  input load;
  input shift;
  output reg [15:0]s_B;
  always @(negedge clk)
    if (load)
     s_B <= in_B;
     else
     begin
     if(shift) s_B <= s_B >> 1; 
     else s_B <= s_B;
     end
endmodule

module lsr(clk, in_A, shift, load, s_A);
  input clk;
  input shift;
  input load;
  input [15:0] in_A;
  output reg [31:0] s_A;
  always @(negedge clk)
  if (load)
    s_A = in_A;
   else
    begin
    if(shift) s_A=s_A<<1;
    else s_A=s_A;
  end
endmodule

module comp(B, z);
  input [15:0] B; 
  output z;
  reg tmp;

  initial tmp=0;
  assign z = (tmp);

    always@(*)
      tmp=(B==0)? 1'b1:1'b0;
endmodule
module acc(clk, A, add, rst, pp);
  input clk;
  input [31:0] A;
  input add;
  input rst;
  output reg [31:0] pp;

  initial pp = 0;
  
  
  always @(negedge clk) 
    if (rst)
      pp <= 32'h00000000; 
    else
      begin
        if (add) pp <= pp + A; 
        else pp <= pp;
      end
endmodule
