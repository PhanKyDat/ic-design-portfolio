module alu_8bit(
    input  [7:0] A,
    input  [7:0] B,
    input  [3:0] opcode,

    output reg [7:0] Y,
    output reg carry,
    output reg zero,
    output reg overflow,
    output reg negative
);

    // Biến trung gian 9-bit dùng cho các phép cộng
    reg [8:0] temp;

    always @(*) begin

        // Giá trị mặc định để ALU luôn là mạch tổ hợp
        Y        = 8'd0;
        carry    = 1'b0;
        overflow = 1'b0;
        temp     = 9'd0;

        case (opcode)

            // 0000: ADD
            4'b0000: begin
                temp = {1'b0, A} + {1'b0, B};

                Y     = temp[7:0];
                carry = temp[8];

                // Tràn số có dấu khi cộng
                overflow =
                    (~A[7] & ~B[7] &  Y[7]) |
                    ( A[7] &  B[7] & ~Y[7]);
            end

            // 0001: SUB
            4'b0001: begin
                Y = A - B;

                // Bằng 1 khi phép trừ cần mượn
                carry = (A < B);

                // Tràn số có dấu khi trừ
                overflow =
                    (~A[7] &  B[7] &  Y[7]) |
                    ( A[7] & ~B[7] & ~Y[7]);
            end

            // 0010: AND
            4'b0010: begin
                Y = A & B;
            end

            // 0011: OR
            4'b0011: begin
                Y = A | B;
            end

            // 0100: XOR
            4'b0100: begin
                Y = A ^ B;
            end

            // 0101: NOT A
            4'b0101: begin
                Y = ~A;
            end

            // 0110: Dịch trái một bit
            4'b0110: begin
                Y = A << 1;
            end

            // 0111: Dịch phải một bit
            4'b0111: begin
                Y = A >> 1;
            end

            // 1000: EQUAL
            4'b1000: begin
                Y = (A == B) ? 8'd1 : 8'd0;
            end

            // 1001: LESS
            4'b1001: begin
                Y = (A < B) ? 8'd1 : 8'd0;
            end

            // 1010: INC
            4'b1010: begin
                temp = {1'b0, A} + 9'd1;

                Y     = temp[7:0];
                carry = temp[8];

                // 127 + 1 gây tràn số có dấu
                overflow = (A == 8'h7F);
            end

            // 1011: DEC
            4'b1011: begin
                Y = A - 8'd1;

                // 0 - 1 cần mượn
                carry = (A == 8'd0);

                // -128 - 1 gây tràn số có dấu
                overflow = (A == 8'h80);
            end

            default: begin
                Y        = 8'd0;
                carry    = 1'b0;
                overflow = 1'b0;
            end

        endcase

        // Hai cờ được tính dựa trên kết quả cuối cùng
        zero     = (Y == 8'd0);
        negative = Y[7];

    end

endmodule
