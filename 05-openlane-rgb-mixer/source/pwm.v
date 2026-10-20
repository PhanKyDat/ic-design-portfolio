`default_nettype none
`timescale 1ns/1ns

module pwm (
    input wire clk,
    input wire reset,
    input wire [7:0] level,
    output reg out
);

reg [7:0] counter;
wire [7:0] counter_next;

assign counter_next = counter + 1;

always @(posedge clk) begin
    if (reset) begin
        counter <= 0;
        out <= 0;
    end else begin
        counter <= counter_next;

        if (counter_next < level)
            out <= 1;
        else
            out <= 0;
    end
end

endmodule
