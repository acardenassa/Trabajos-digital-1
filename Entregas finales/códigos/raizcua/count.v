module count (
    input clk,
    input ld,
    input resta,
    input [5:0] n,                 
    output reg [5:0] out_count); 
    always @(negedge clk) begin
        if (ld)
            out_count <= n;                  
        else if (resta)
            out_count <= out_count - 1;      
        else
            out_count <= out_count;          
    end
endmodule