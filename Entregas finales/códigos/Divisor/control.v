module control (
    input clk,
    input rst_hardware, 
    input init,
    input comp,
    input x,
    output reg rst,
    output reg sh_1,
    output reg sh_2,
    output reg new_Resi,
    output reg done
);

    // Definición de los estados
    reg [2:0] state, next_state;

    localparam START   = 3'b000,
               SHIFT_A = 3'b001,
               CHECK_1 = 3'b010,
               RESP_1  = 3'b011,
               RESP_0  = 3'b100,
               CHECK_2 = 3'b101,
               DONE    = 3'b110;

// 2. Bloque secuencial: Transición de estados
always @(posedge clk) begin
    if (rst_hardware) begin
        state <= START;
    end else begin
    case(state)

    START: begin
        if(init)
            state <= SHIFT_A;
        else
            state <= START;
    end

    SHIFT_A: begin
        state <= CHECK_1;
    end

    CHECK_1: begin
        if (comp)
            state<= RESP_0;
        else
            state <=RESP_1;
    end

    RESP_0: begin
        state<=CHECK_2;
    end

    RESP_1: begin
        state<=CHECK_2;
    end

    CHECK_2: begin
        if (x)
            state<=DONE;
        else
            state<=SHIFT_A;
    end

    DONE: begin
        state<=START;
    end
endcase
end
end

    always @(state) 
    begin
        case(state)

    START: begin
        rst = 1;
        sh_1 = 0;
        sh_2 = 0;
        new_Resi = 0;
        done = 0;
    end

    SHIFT_A: begin
        rst = 0;
        sh_1 = 1;
        sh_2 = 0;
        new_Resi = 0;
        done = 0;
    end

    CHECK_1: begin
        rst = 0;
        sh_1 = 0;
        sh_2 = 0;
        new_Resi = 0;
        done = 0;
    end

    RESP_0: begin
        rst = 0;
        sh_1 = 0;
        sh_2 = 1;
        new_Resi = 0;
        done = 0;
    end

    RESP_1: begin
        rst = 0;
        sh_1 = 0;
        sh_2 = 1;
        new_Resi = 1;
        done = 0;
    end

    CHECK_2: begin
        rst = 0;
        sh_1 = 0;
        sh_2 = 0;
        new_Resi = 0;
        done = 0;
    end

    DONE: begin
        rst = 0;
        sh_1 = 0;
        sh_2 = 0;
        new_Resi = 0;
        done = 1;
    end

    endcase
end
endmodule