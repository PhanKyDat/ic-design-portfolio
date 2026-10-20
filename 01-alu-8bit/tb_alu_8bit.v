`timescale 1ns/1ps

module tb_alu_8bit;

    reg  [7:0] A;
    reg  [7:0] B;
    reg  [3:0] opcode;

    wire [7:0] Y;
    wire carry;
    wire zero;
    wire overflow;
    wire negative;

    integer pass_count;
    integer fail_count;

    // Kết nối testbench với ALU
    alu_8bit dut (
        .A(A),
        .B(B),
        .opcode(opcode),
        .Y(Y),
        .carry(carry),
        .zero(zero),
        .overflow(overflow),
        .negative(negative)
    );

    // Task chạy và kiểm tra một trường hợp
    task run_test;

        input [7:0] a_in;
        input [7:0] b_in;
        input [3:0] op_in;

        input [7:0] expected_y;
        input expected_c;
        input expected_z;
        input expected_v;
        input expected_n;

        begin

            A      = a_in;
            B      = b_in;
            opcode = op_in;

            // Chờ mạch tổ hợp cập nhật
            #10;

            if (
                (Y        === expected_y) &&
                (carry    === expected_c) &&
                (zero     === expected_z) &&
                (overflow === expected_v) &&
                (negative === expected_n)
            ) begin

                pass_count = pass_count + 1;

                $display(
                    "PASS | A=%0d B=%0d OP=%b | Y=%0d C=%b Z=%b V=%b N=%b",
                    A,
                    B,
                    opcode,
                    Y,
                    carry,
                    zero,
                    overflow,
                    negative
                );

            end
            else begin

                fail_count = fail_count + 1;

                $display(
                    "FAIL | A=%0d B=%0d OP=%b | Y=%0d C=%b Z=%b V=%b N=%b",
                    A,
                    B,
                    opcode,
                    Y,
                    carry,
                    zero,
                    overflow,
                    negative
                );

                $display(
                    "     | MONG DOI       | Y=%0d C=%b Z=%b V=%b N=%b",
                    expected_y,
                    expected_c,
                    expected_z,
                    expected_v,
                    expected_n
                );

            end

        end

    endtask

    initial begin

        // Tạo file waveform cho GTKWave
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_alu_8bit);

        pass_count = 0;
        fail_count = 0;

        A      = 8'd0;
        B      = 8'd0;
        opcode = 4'd0;

        $display("======================================================");
        $display("          BAT DAU KIEM THU ALU 8-BIT");
        $display("======================================================");

        // 1. ADD: 12 + 3 = 15
        run_test(
            8'd12, 8'd3, 4'b0000,
            8'd15, 1'b0, 1'b0, 1'b0, 1'b0
        );

        // 2. SUB: 12 - 3 = 9
        run_test(
            8'd12, 8'd3, 4'b0001,8'd9, 1'b0, 1'b0, 1'b0, 1'b0
        );

        // 3. AND: 12 AND 3 = 0
        run_test(
            8'd12, 8'd3, 4'b0010,
            8'd0, 1'b0, 1'b1, 1'b0, 1'b0
        );

        // 4. OR: 12 OR 3 = 15
        run_test(
            8'd12, 8'd3, 4'b0011,
            8'd15, 1'b0, 1'b0, 1'b0, 1'b0
        );

        // 5. XOR: 12 XOR 3 = 15
        run_test(
            8'd12, 8'd3, 4'b0100,
            8'd15, 1'b0, 1'b0, 1'b0, 1'b0
        );

        // 6. NOT: NOT 12 = 243
        run_test(
            8'd12, 8'd3, 4'b0101,
            8'd243, 1'b0, 1'b0, 1'b0, 1'b1
        );

        // 7. SHL: 12 << 1 = 24
        run_test(
            8'd12, 8'd3, 4'b0110,
            8'd24, 1'b0, 1'b0, 1'b0, 1'b0
        );

        // 8. SHR: 12 >> 1 = 6
        run_test(
            8'd12, 8'd3, 4'b0111,
            8'd6, 1'b0, 1'b0, 1'b0, 1'b0
        );

        // 9. EQUAL: 12 == 12
        run_test(
            8'd12, 8'd12, 4'b1000,
            8'd1, 1'b0, 1'b0, 1'b0, 1'b0
        );

        // 10. LESS: 5 < 9
        run_test(
            8'd5, 8'd9, 4'b1001,
            8'd1, 1'b0, 1'b0, 1'b0, 1'b0
        );

        // 11. INC: 12 + 1 = 13
        run_test(
            8'd12, 8'd0, 4'b1010,
            8'd13, 1'b0, 1'b0, 1'b0, 1'b0
        );

        // 12. DEC: 12 - 1 = 11
        run_test(
            8'd12, 8'd0, 4'b1011,
            8'd11, 1'b0, 1'b0, 1'b0, 1'b0
        );

        // 13. Kiểm tra Carry: 255 + 1
        run_test(
            8'd255, 8'd1, 4'b0000,
            8'd0, 1'b1, 1'b1, 1'b0, 1'b0
        );

        // 14. Kiểm tra Overflow: 127 + 1
        run_test(
            8'd127, 8'd1, 4'b0000,
            8'd128, 1'b0, 1'b0, 1'b1, 1'b1
        );

        $display("======================================================");
        $display(
            "TONG KET: %0d PASS - %0d FAIL",
            pass_count,
            fail_count
        );
        $display("======================================================");

        #10;
        $finish;

    end

endmodule
