module control (
    input clk,
    input rst_hardware, 
    input init,
    input x1,      // Viene del comparador: Indica si U >= 5
    input x2,      // Viene del comparador: Indica si D >= 5
    input z,       // Viene de comp_2: Indica si el número binario ya es cero
    output reg ld,
    output reg sh,
    output reg new_U,
    output reg new_D,
    output reg comp_U,
    output reg comp_D,
    output reg done
);

    // Definición de los estados
    reg [3:0] state;

    localparam START   = 4'd0,
               LOAD    = 4'd1,
               CHECK_U = 4'd2,
               ADD_U   = 4'd3,
               CHECK_D = 4'd4,
               ADD_D   = 4'd5,
               SHIFT_A = 4'd6,
               CHECK_Z = 4'd7,
               DONE    = 4'd8;

// 1. Bloque secuencial: Transición de estados
always @(posedge clk) begin
    if (rst_hardware) begin
        state <= START;
    end else begin
        case(state)

        START: begin
            if(init)
                state <= LOAD;
            else
                state <= START;
        end

        LOAD: begin
            state <= SHIFT_A;
        end

        SHIFT_A: begin
            state <= CHECK_Z;
        end

        CHECK_Z: begin
            
            if (z)
                state <= DONE;
            else
                state <= CHECK_U;
        end


        CHECK_U: begin
            
            if (x1)
                state <= ADD_U;
            else
                state <= CHECK_D;
        end

        ADD_U: begin
            state <= CHECK_D;
        end

        CHECK_D: begin
            // Si las decenas son >= 5, vamos a sumarles 3
            if (x2)
                state <= ADD_D;
            else
                state <= SHIFT_A;
        end

        ADD_D: begin
            state <= SHIFT_A;
        end

        

        
        DONE: begin
                state <= START;
        end
        
        default: state <= START;
        
        endcase
    end
end

// 2. Bloque combinacional
always @(state) begin
    case(state)

        START: begin
            ld = 0;
            sh = 0;
            new_U = 0;
            new_D = 0;
            comp_U = 0;
            comp_D = 0;
            done = 0;
        end

        LOAD: begin
            ld = 1;
            sh = 0;
            new_U = 0;
            new_D = 0;
            comp_U = 0;
            comp_D = 0;
            done = 0;
        end

        SHIFT_A: begin
            ld = 0;
            sh = 1;    
            new_U = 0;
            new_D = 0;
            comp_U = 0;
            comp_D = 0;
            done = 0;
        end


        CHECK_Z: begin
            ld = 0;
            sh = 0;
            new_U = 0;
            new_D = 0;
            comp_U = 0;
            comp_D = 0;
            done = 0;
        end

        CHECK_U: begin
            ld = 0;
            sh = 0;
            new_U = 0;
            new_D = 0;
            comp_U = 1; 
            comp_D = 0;
            done = 0;
        end

        ADD_U: begin
            ld = 0;
            sh = 0;
            new_U = 1;  
            new_D = 0;
            comp_U = 0;
            comp_D = 0;
            done = 0;
        end

        CHECK_D: begin
            ld = 0;
            sh = 0;
            new_U = 0;
            new_D = 0;
            comp_U = 0;
            comp_D = 1; 
            done = 0;
        end

        ADD_D: begin
            ld = 0;
            sh = 0;
            new_U = 0;
            new_D = 1;
            comp_U = 0;
            comp_D = 0;
            done = 0;
        end
        

        DONE: begin
            ld = 0;
            sh = 0;
            new_U = 0;
            new_D = 0;
            comp_U = 0;
            comp_D = 0;
            done = 1;   
        end

        default: begin
            ld = 0;
            sh = 0;
            new_U = 0;
            new_D = 0;
            comp_U = 0;
            comp_D = 0;
            done = 0;
        end

    endcase
end

endmodule