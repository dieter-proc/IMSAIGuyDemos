
module C3LFSRvga_top (
    input clk, // onboard crystal osc 50MHz
    output[3:0] r4, // DE0 board 16 grade R
    output[3:0] g4, // DE0 board 16 grade G
    output[3:0] b4, // DE0 board 16 grade B
    output hsync,     // Physical pin connected to VGA DB15 connector HSYNC pin
    output vsync      // Physical pin connected to VGA DB15 connector VSYNC pin
);

wire video_on;
wire [3:0] v15r, v15g, v15b;
reg bw = 1; // bw=1 black-white mode, bw=0 color mode
assign v15r = bw ? (lfsr[0] ? 15 :0) : lfsr[3:0];
assign v15g = bw ? (lfsr[0] ? 15 :0) : lfsr[7:4];
assign v15b = bw ? (lfsr[0] ? 15 :0) : lfsr[11:8];
assign r4 = video_on ? v15r : 0;
assign g4 = video_on ? v15g : 0;
assign b4 = video_on ? v15b : 0;

wire [9:0] vga_x, vga_y; // vga pixel coordinates, not used here

// Instantiate VGA Controller Engine
vga_sync vga_driver (
    .clk(clkdiv[0]),
    .h_sync(hsync),
    .v_sync(vsync),
    .video_on(video_on),
    .x(vga_x),
    .y(vga_y)
);


reg [3:0] clkdiv = 0;
assign leds = lfsr[9:0];

// 32bit LFSR for better long period non-repeative randomness
reg [31:0] lfsr = 32'h10205EED; // seed
wire feedback;
assign feedback = ((((1 ^ lfsr[9]) ^ lfsr[19]) ^ lfsr[21]) ^ lfsr[30]);

always @(posedge clkdiv[1])
begin
	lfsr <= {lfsr[30:0], feedback};
end

always @(posedge clk)
begin
	clkdiv <= clkdiv + 1;
end


endmodule
