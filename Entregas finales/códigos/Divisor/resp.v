module resp (
    input clk,
    input rst,
    input sh_2,
    input r0, 
    output reg [31:0] resp_out                        
);

    always @(negedge clk) begin
        if (rst) begin                 
            resp_out <= 32'd0;         
        end
        else if (sh_2) begin
            resp_out <= {resp_out[30:0], r0};
        end
        else begin
            resp_out <= resp_out;   
        end
    end

endmodule