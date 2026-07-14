module num_divid(
    input clk,
    input rst,
    input sh_1,
    input add_new_Resi,
    input [31:0] divid,
    input [31:0] new_resi,
    output [31:0] resi_out,
    output [31:0] sub_a_out);
    reg [63:0] registro_completo;
    
    assign resi_out  = registro_completo[63:32]; 
    assign sub_a_out = registro_completo[31:0];

    always @(negedge clk) begin
       if (rst)begin
            registro_completo <= {32'd0, divid};
        end
        else if  (sh_1)begin
            registro_completo <= {registro_completo[62:0], 1'b0};
        end
        else if (add_new_Resi)begin
            registro_completo <= {new_resi, registro_completo[31:0]};
        end
        else begin
            registro_completo <= registro_completo; // Mantiene el valor
        end
    end
endmodule