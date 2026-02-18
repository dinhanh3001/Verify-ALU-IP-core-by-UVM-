module tinyalu (
    input  logic [7:0]  A,
    input  logic [7:0]  B,
    input  logic [2:0]  op,
    input  logic        clk,
    input  logic        reset_n,
    input  logic        start,
    output logic        done,
    output logic [15:0] result
);
    // Logic đơn giản của ALU
    always_ff @(posedge clk) begin
        if (!reset_n) begin
            result <= 16'h0000;
            done   <= 1'b0;
        end else begin
            done <= 1'b0; // Mặc định done = 0
            if (start) begin
                done <= 1'b1; // Ops này đơn giản nên xong ngay sau 1 chu kỳ
                case (op)
                    3'b001: result <= A + B;       // ADD
                    3'b010: result <= A & B;       // AND
                    3'b011: result <= A ^ B;       // XOR
                    3'b100: result <= A * B;       // MUL
                    default: done <= 1'b0;         // NO_OP không sinh done
                endcase
            end
        end
    end
endmodule : tinyalu