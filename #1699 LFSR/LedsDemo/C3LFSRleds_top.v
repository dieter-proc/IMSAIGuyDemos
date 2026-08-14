
module C3LFSRleds_top (
	input clk, // omboard crystal osc 50MHz
	output [9:0] leds // DE0 onboard 10 leds
);

reg [26:0] clkdiv = 0;
assign leds = lfsr[9:0];

reg [15:0] lfsr = 16'h5EED; // initial seed
wire feedback;
// combine yout LFSR rolling bits
assign feedback = ((((1 ^ lfsr[9]) ^ lfsr[12]) ^ lfsr[14]) ^ lfsr[15]);
//assign feedback = lfsr[15] ^ lfsr[14] ^ lfsr[12] ^ lfsr[3] ^ 1;

always @(posedge clkdiv[22])
begin
	lfsr <= {lfsr[14:0], feedback};
end

always @(posedge clk)
begin
	clkdiv <= clkdiv + 1;
end


endmodule
