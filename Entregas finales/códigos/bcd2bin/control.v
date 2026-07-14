module control (
    input clk,
    input rst_hardware,
    input init,
    input error,
    input x1,      // U >= 8
    input x2,      // D >= 8
    input z,       // i == 0
    output reg ld,
    output reg sh,
    output reg comp_U,
    output reg comp_D,
    output reg new_U,
    output reg new_D,
    output reg done
);

reg [3:0] state;
localparam START   = 4'b0000,
           SH       = 4'b0001,
           CHECK_1  = 4'b0010,
           CHECK_U  = 4'b0011,
           SUM_U    = 4'b0100,
           CHECK_D  = 4'b0101,
           SUM_D    = 4'b0110,
           DONE     = 4'b0111;

// 1. Bloque secuencial: Transicion de estados
always @(posedge clk) begin
    if (rst_hardware) begin
        state <= START;
    end else begin
        case(state)
            START: begin
                if (init && !error)
                    state <= SH;
                else
                    state <= START;
            end
            SH: begin
                state <= CHECK_1;
            end
            CHECK_1: begin
                if (z)
                    state <= DONE;
                else
                    state <= CHECK_U;
            end
            CHECK_U: begin
                if (x1)
                    state <= SUM_U;
                else
                    state <= CHECK_D;
            end
            SUM_U: begin
                state <= CHECK_D;
            end
            CHECK_D: begin
                if (x2)
                    state <= SUM_D;
                else
                    state <= SH;
            end
            SUM_D: begin
                state <= SH;
            end
            DONE: begin
                    state <= START;
            end
            default: state <= START;
        endcase
    end
end

// 2. Bloque combinacional: Salidas de control segun el estado
always @(*) begin
    case(state)
        START:begin
            ld=1; 
            sh=0; 
            comp_U=0; 
            comp_D=0; 
            new_U=0; 
            new_D=0; 
            done=0;
        end
        SH:begin 
            ld=0;
            sh=1;
            comp_U=0;
            comp_D=0;
            new_U=0;
            new_D=0;
            done=0;
        end
        CHECK_1:
        begin
            ld=0;
            sh=0;
            comp_U=0;
            comp_D=0;
            new_U=0;
            new_D=0;
            done=0;
        end

        CHECK_U:begin
            ld=0;
            sh=0;
            comp_U=1;
            comp_D=0;
            new_U=0;
            new_D=0;
            done=0;
        end

        SUM_U:begin
            ld=0;
            sh=0;
            comp_U=0;
            comp_D=0;
            new_U=1;
            new_D=0;
            done=0;
        end
        
        CHECK_D:begin
            ld=0;
            sh=0;
            comp_U=0;
            comp_D=1;
            new_U=0;
            new_D=0;
            done=0;
        end
        
        SUM_D:begin
            ld=0;
            sh=0;
            comp_U=0;
            comp_D=0;
            new_U=0;
            new_D=1;
            done=0;
        end
        
        DONE:begin
            ld=0;
            sh=0;
            comp_U=0;
            comp_D=0;
            new_U=0;
            new_D=0;
            done=1;
        end
        default:begin 
            ld=0;
            sh=0;
            comp_U=0;
            comp_D=0;
            new_U=0;
            new_D=0;
            done=0;
        end
    endcase
end

endmodule