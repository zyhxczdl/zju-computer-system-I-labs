// Lab3-1：四状态有限状态机；rstn 为低有效异步复位，回到 S0。
// S0~S2 中 a 的优先级高于 b；a 推进状态，b 回到 S0，否则保持。
// S3 为吸收状态，仅复位能够退出。
module FSM(
    input rstn,
    input clk,
    input a,
    input b,
    output [1:0] state
);

    typedef enum logic [1:0] {
    S0 = 2'b00,
    S1 = 2'b01,
    S2 = 2'b10,
    S3 = 2'b11
} state_t;

state_t current_state;
state_t next_state;

always_ff @(posedge clk or negedge rstn) begin
    if(!rstn) begin
        current_state <= S0;
    end
    else begin
        current_state <= next_state;
    end
end

always_comb begin
    case(current_state)
        S0: begin
            if(a == 1'b1)       next_state = S1;
            else if(b == 1'b1)  next_state = S0;
            else                next_state = S0;
        end
        S1: begin
            if(a == 1'b1)       next_state = S2;
            else if(b == 1'b1)  next_state = S0;
            else                next_state = S1;
        end
        S2: begin
            if(a == 1'b1)       next_state = S3;
            else if(b == 1'b1)  next_state = S0;
            else                next_state = S2;
        end
        S3: begin
            next_state = S3;
        end
    endcase
end

assign state = current_state;

endmodule