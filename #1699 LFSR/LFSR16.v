// 16-bit LFSR

module LFSR16 (
	input clk,
	output [7:0] data
);

assign data = lfsr[7:0];

reg [15:0] lfsr = 0;
wire feedback;
assign feedback = lfsr[15] ^ lfsr[14] ^ lfsr[12] ^ lfsr[3] ^ 1;

always @(posedge clk)
begin
	lfsr <= {lfsr[14:0], feedback};
end

endmodule
