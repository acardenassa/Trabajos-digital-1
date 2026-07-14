module control (
    input clk,
    input rst_hardware,
    input init,
    input lsbb,
    input x,
    output reg sh,
    output reg reset,
    output reg add,
    output reg done
);

reg [2:0] state;
localparam START   = 3'b000,
           REVISAR = 3'b001,
           SUMADOR = 3'b010,
           CORRER  = 3'b011,
           COMPARA = 3'b100,
           HECHO   = 3'b101;

// 1. Bloque secuencial: Transicion de estados
always @(posedge clk) begin
    if (rst_hardware) begin
        state <= START;
    end else begin
        case(state)
            START: begin
                if (init)
                    state <= REVISAR;
                else
                    state <= START;
            end
            REVISAR: begin
                if (lsbb)
                    state <= SUMADOR;
                else
                    state <= CORRER;
            end
            SUMADOR: begin
                state <= CORRER;
            end
            CORRER: begin
                state <= COMPARA;
            end
            COMPARA: begin
                if (x)
                    state <= HECHO;
                else
                    state <= REVISAR;
            end
            HECHO: begin
                if (init)
                    state <= HECHO;
                else
                    state <= START;
            end
            default: state <= START;
        endcase
    end
end

// 2. Bloque combinacional: Salidas de control segun el estado
always @(*) begin
    case(state)
        START:   begin 
            sh=0; 
            reset=1; 
            add=0; 
            done=0; 
        end
        REVISAR: begin 
            sh=0; 
            reset=0; 
            add=0; 
            done=0; 
        end
        SUMADOR: begin 
            sh=0; 
            reset=0; 
            add=1; 
            done=0; 
        end
        CORRER:  begin 
            sh=1; 
            reset=0; 
            add=0; 
            done=0; 
        end
        COMPARA: begin 
            sh=0; 
            reset=0; 
            add=0; 
            done=0; 
        end
        HECHO:   begin 
            sh=0; 
            reset=0; 
            add=0; 
            done=1; 
        end
        default: begin 
            sh=0; 
            reset=0; 
            add=0; 
            done=0; 
        end
    endcase
end

endmodule