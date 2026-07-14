module control (
    input clk,
    input rst_hardware,
    input init,
    input suf,     // viene del sum_C2
    input z,       // viene del contador 
    output reg ld,
    output reg sh,
    output reg ro,
    output reg nr,
    output reg ld_comp,
    output reg done
);

// Definicion de los estados
reg [2:0] state, next_state;
localparam START   = 3'b000,
           CORRER   = 3'b001,
           LD_COMP  = 3'b010,
           SUM      = 3'b011,
           R_0      = 3'b100,
           DONE     = 3'b101;

// 1. Bloque secuencial:
always @(posedge clk) begin
    if (rst_hardware) begin
        state <= START;
    end else begin
        case(state)
            START: begin
                if (init)
                    state <= CORRER;
                else
                    state <= START;
            end
            CORRER: begin
                state <= LD_COMP;
            end
            LD_COMP: begin
                if (suf)
                    state <= SUM;
                else
                    state <= R_0;
            end
            SUM: begin
                if (z)
                    state <= DONE;
                else
                    state <= CORRER;
            end
            R_0: begin
                if (z)
                    state <= DONE;
                else
                    state <= CORRER;
            end
            DONE: begin
                if (~init)
                    state <= START;
                else
                    state <= DONE;
            end
            default: state <= START;
        endcase
    end
end

// 2. Bloque combinacional:
always @(*) begin
    case(state)
        START: begin
            done    = 0;
            sh      = 0;
            ld      = 1;
            nr      = 0;
            ro      = 0;
            ld_comp = 0;
        end
        CORRER: begin
            done    = 0;
            sh      = 1;
            ld      = 0;
            nr      = 0;
            ro      = 0;
            ld_comp = 0;
        end
        LD_COMP: begin
            done    = 0;
            sh      = 0;
            ld      = 0;
            nr      = 0;
            ro      = 0;
            ld_comp = 1;
        end
        SUM: begin
            done    = 0;
            sh      = 0;
            ld      = 0;
            nr      = 1;
            ro      = 1;
            ld_comp = 0;
        end
        R_0: begin
            done    = 0;
            sh      = 0;
            ld      = 0;
            nr      = 0;
            ro      = 0;
            ld_comp = 0;
        end
        DONE: begin
            done    = 1;
            sh      = 0;
            ld      = 0;
            nr      = 0;
            ro      = 0;
            ld_comp = 0;
        end
        default: begin
            done    = 0;
            sh      = 0;
            ld      = 0;
            nr      = 0;
            ro      = 0;
            ld_comp = 0;
        end
    endcase
end

endmodule