
module vga_sync(
    input clk,          // 25 MHz pixel clock
    output reg h_sync,
    output reg v_sync,
    output reg video_on,
    output [9:0] x,     // Current pixel X (0-639)
    output [9:0] y      // Current pixel Y (0-479)
);
    // Timing parameters for 640x480 @ 60Hz
    localparam HD = 640; // Horizontal Display
    localparam HF = 16;  // Horizontal Front Porch
    localparam HB = 48;  // Horizontal Back Porch
    localparam HR = 96;  // Horizontal Retrace / Sync Pulse
    localparam VD = 480; // Vertical Display
    localparam VF = 10;  // Vertical Front Porch
    localparam VB = 33;  // Vertical Back Porch
    localparam VR = 2;   // Vertical Retrace / Sync Pulse

    reg [9:0] h_count = 0;
    reg [9:0] v_count = 0;

    // Counters
    always @(posedge clk) begin
        if (h_count == (HD + HF + HB + HR - 1)) begin
            h_count <= 0;
            if (v_count == (VD + VF + VB + VR - 1))
                v_count <= 0;
            else
                v_count <= v_count + 1;
        end else begin
            h_count <= h_count + 1;
        end
    end

    // Sync pulses (active low)
    always @(posedge clk) begin
        h_sync <= ~((h_count >= (HD + HF)) && (h_count < (HD + HF + HR)));
        v_sync <= ~((v_count >= (VD + VF)) && (v_count < (VD + VF + VR)));
        video_on <= (h_count < HD) && (v_count < VD);
    end

    assign x = (h_count < HD) ? h_count : 0;
    assign y = (v_count < VD) ? v_count : 0;
endmodule
