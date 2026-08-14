// 24-bit LFSR

module LFSR24 (
	input clk,
	output pin_out
);

assign data = lfsr[0];

reg [23:0] lfsr = 24'h37E01; // seed
wire feedback;
assign feedback = lfsr[22] ^ lfsr[15] ^ lfsr[14] ^ lfsr[12] ^ lfsr[3] ^ 1;

always @(posedge clk)
begin
	lfsr <= {lfsr[14:0], feedback};
end

endmodule
