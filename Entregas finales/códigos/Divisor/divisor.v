module divisor(
    input clk,
    input rst_hardware,   
    input init,           
    input [31:0] divida,  
    input [31:0] divisb,  
    output [31:0] res_div,
    output [31:0] resi,   
    output done_div      
);

    
    // CABLES INTERNOS DE CONTROL 
  
    wire w_rst;
    wire w_sh_1;
    wire w_sh_2;
    wire w_new_Resi;
    wire w_comp;
    wire w_x;

  
    // 2. CABLES INTERNOS DE DATOS
   
    wire [31:0] w_resi_out;      
    wire [31:0] w_sub_a_out;     
    wire [31:0] w_num_divisor_out;
    wire [31:0] w_new_resi_bus;   
    wire [5:0]  w_out_count;     

 // 3. LÓGICA DE ACOPLAMIENTO 

    assign w_x = (w_out_count == 4'd0);

 
    assign resi = w_resi_out;


    
    // 4. CONEXIÓN DE MÓDULOS
  

    control control_unit (
        .clk(clk),
        .rst_hardware(rst_hardware),
        .init(init),
        .comp(w_comp),
        .x(w_x),
        .rst(w_rst),
        .sh_1(w_sh_1),
        .sh_2(w_sh_2),
        .new_Resi(w_new_Resi),
        .done(done_div)
    );

    num_divid dividendo (
        .clk(clk),
        .rst(w_rst),
        .sh_1(w_sh_1),
        .add_new_Resi(w_new_Resi),
        .divid(divida),
        .new_resi(w_new_resi_bus),
        .resi_out(w_resi_out),
        .sub_a_out(w_sub_a_out)
    );


    num_divisor divisor (
        .clk(clk),
        .ld(w_rst),
        .b(divisb),
        .num_divisor_out(w_num_divisor_out)
    );


    sumadorC2 restador (
        .resi_in(w_resi_out),
        .b_in(w_num_divisor_out),
        .new_resi(w_new_resi_bus),
        .comp(w_comp)
    );

    
    resp respuesta (
        .clk(clk),
        .rst(w_rst),
        .sh_2(w_sh_2),
        .r0(w_new_Resi), 
        .resp_out(res_div)
    );


    count contador (
        .clk(clk),
        .ld(w_rst),
        .resta(w_sh_1),
        .n(6'd32),
        .out_count(w_out_count)
    );

endmodule