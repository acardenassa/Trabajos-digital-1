module control(

    input clk,
    input rst,
    input init,
    input x,
    input lsb_count,

    output reg ld,
    output reg sum,
    output reg done,
    output reg pari

);

parameter START   = 3'd0;
parameter LOAD    = 3'd1;
parameter SUM_SH  = 3'd2;
parameter CHECK_1 = 3'd3;
parameter CHECK_2 = 3'd4;
parameter PARI    = 3'd5;
parameter DONE    = 3'd6;

reg [2:0] state;


//======================================
// Máquina de estados
//======================================

always @(posedge clk) begin

    if (rst)
        state <= START;

    else begin

        case(state)

            START:
                if(init)
                    state <= LOAD;
                else
                    state <= START;

            LOAD:
                state <= SUM_SH;

            SUM_SH:
                state <= CHECK_1;

            CHECK_1:
                if(x)
                    state <= PARI;
                else
                    state <= SUM_SH;

            PARI:
                state <= DONE;

            DONE:
                state <= START;

            default:
                state <= START;

        endcase

    end

end


//======================================
// Lógica de salida
//======================================

always @(*) begin

    ld   = 0;
    sum  = 0;
    done = 0;
    pari = 0;

    case(state)

        START: begin
            ld   = 0;
            sum  = 0;
            done = 0;
            pari = 0;
        end

        LOAD: begin
            ld   = 1;
            sum  = 0;
            done = 0;
            pari = 0;
        end

        SUM_SH: begin
            ld   = 0;
            sum  = 1;
            done = 0;
            pari = 0;
        end

        CHECK_1: begin
            ld   = 0;
            sum  = 0;
            done = 0;
            pari = 0;
        end

        CHECK_2: begin
            ld   = 0;
            sum  = 0;
            done = 0;
            pari = 0;
        end

        PARI: begin
            ld   = 0;
            sum  = 0;
            done = 0;
            pari = 1;
        end


        DONE: begin
            ld   = 0;
            sum  = 0;
            done = 1;
            pari = 0;
        end

    endcase

end

endmodule