module sum_C2 (
    input  [31:0] resi_in,
    input  [31:0] term_in,   // = (Comp<<1)+1, ya armado afuera
    output [31:0] new_resi,
    output SUF
);

assign new_resi = resi_in - term_in;
assign SUF = ~new_resi[31];   // SUF=1 si el resultado es >=0 

endmodule