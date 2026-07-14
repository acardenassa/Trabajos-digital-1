module val_error(
    input  [3:0] A,   // decenas
    input  [3:0] B,   // unidades
    output Error
);

wire Error1;
wire Error2;

assign Error1 = A[3] & (A[2] | A[1]);
assign Error2 = B[3] & (B[2] | B[1]);
assign Error  = Error1 | Error2;

endmodule