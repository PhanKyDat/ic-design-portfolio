`default_nettype none
module timer(
    input clk,
    input reset,
    input load,
    input [15:0] cycles,
    output busy
);

    reg [15:0] counter;

    always @(posedge clk) begin
        if(reset)
            counter <= 0;
        else if (load)
            counter <= cycles;
        else if (counter > 0)
            counter <= counter - 1'b1;
    end

    assign busy = counter > 0;

`ifdef FORMAL
    // Cờ đánh dấu các trạng thái quá khứ hợp lệ
    reg f_past_valid = 0;

    // ÉP MẠCH KHỞI ĐỘNG Ở TRẠNG THÁI RESET (Chú ý dấu chấm phẩy ở cuối)
    initial assume(reset);

    always @(posedge clk) begin
        // GIẢ ĐỊNH TIMER KHÔNG ĐƯỢC NẠP SỐ 0
        assume(cycles > 0);

        f_past_valid <= 1;

        // 2.1a Khoảnh khắc tín hiệu load bật lên 1
        _loaded_: cover(load == 1'b1 && f_past_valid && !reset);

        // 2.1b Khoảnh khắc tín hiệu busy chuyển từ 0 lên 1 (vừa mới khởi động)
        _started_: cover(busy == 1'b1 && !$past(busy) && f_past_valid && !reset);

        // 2.2 Khoảnh khắc timer đếm xong (busy từ 1 rớt xuống 0)
        _finished_: cover(!busy && $past(busy) && f_past_valid && !$past(reset));

        if (f_past_valid) begin
            // 3.1 Timer goes busy: Nếu thanh ghi counter có giá trị, tín hiệu busy bắt buộc phải ở mức 1
            if (counter != 0) begin
                assert(busy == 1'b1);
            end

            // 3.2 Timer can be loaded: Ngay sau chu kỳ có tín hiệu load, counter phải chứa giá trị từ cổng cycles
            if ($past(load) && !$past(reset)) begin
                assert(counter == $past(cycles));
            end

            // 3.3 Timer counts down: Nếu timer đang hoạt động và không bị nạp mới, counter phải giảm 1 đơn vị
            if ($past(busy) && $past(counter) != 0 && !$past(load) && !$past(reset)) begin
                assert(counter == $past(counter) - 1);
            end
        end
    end
`endif
    
endmodule
