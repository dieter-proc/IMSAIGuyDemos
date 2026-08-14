
module C3LFSR1_top (
	input clk, // DE0 onboard 50MHz clock
	output pin_out // single bit output
);

reg [26:0] clkdiv = 0; // to slow down
assign pin_out = lfsr[0];

reg [15:0] lfsr = 16'h5EED; // seed
wire feedback;
// choose LFSR combination bits
assign feedback = lfsr[15] ^ lfsr[14] ^ lfsr[9] ^ lfsr[3] ^ 1;

always @(posedge clkdiv[8])
begin
	lfsr <= {lfsr[14:0], feedback}; // shift up
end

always @(posedge clk)
begin
	clkdiv <= clkdiv + 1;
end


endmodule
