module sumadorC2 (
    input [31:0] resi_in,
    input [31:0] b_in,
    output [31:0] new_resi,
    output comp
);

assign new_resi = resi_in - b_in;
assign comp = new_resi[31];

endmodule