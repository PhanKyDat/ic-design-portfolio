`default_nettype none
`timescale 1ns/1ns
module debounce (
    input wire clk,
    input wire reset,
    input wire button,
    output reg debounced
);
reg [7:0] history;

always @(posedge clk) begin
    if (reset) begin
        history <= 0;
        debounced <= 0;
    end else begin
        history <= {history[6:0], button};

    if (history == 8'b11111111)
        debounced <= 1;
    else if (history == 8'b00000000)
        debounced <= 0;
    end
end

endmodule
