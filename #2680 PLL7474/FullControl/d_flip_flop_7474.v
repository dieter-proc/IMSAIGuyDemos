
module d_flip_flop_7474 (
    input wire d,         // Data input
    input wire clk,       // Clock input (Positive edge triggered)
    input wire set_n,     // Asynchronous Preset/Set (Active-Low)
    input wire reset_n,   // Asynchronous Clear/Reset (Active-Low)
    output reg q,         // True Output Q
    output wire q_n     // Complementary Output Q_bar
);

    // Complementary output logic
    assign q_n = ~q;

    // Asynchronous behavior for Set/Reset and Synchronous for Clock
    //always @(posedge clk or negedge set_n or negedge reset_n) begin
    always @(posedge clk or negedge set_n or negedge reset_n) begin
        if (!reset_n) begin
            // Clear takes priority when both are asserted, or when reset is active
            q <= 1'b0;
        end
        else if (!set_n) begin
            // Preset takes action if reset is not active
            q <= 1'b1;
        end
        else begin
            // Normal operation on the rising edge of the clock
            q <= d;
        end
    end

endmodule
