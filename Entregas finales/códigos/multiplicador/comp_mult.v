module comp_mult(
    input  [15:0] B,
    output X
);

assign X = (B == 16'd0);

endmodule