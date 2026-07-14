module resi_subA(
    input clk,
    input ld,              
    input sh,               
    input nr,              
    input  [31:0] radicando,
    input  [31:0] new_resi, 
    output [31:0] resi_out, 
    output [31:0] subA_out  
);

reg [63:0] A;

always @(negedge clk) begin
    if (ld)
        A <= {32'b0, radicando};
    else if (sh)
        A <= A << 2;
    else if (nr)
        A <= {new_resi, A[31:0]};
    else
        A <= A;
end

assign resi_out = A[63:32];
assign subA_out = A[31:0];

endmodule