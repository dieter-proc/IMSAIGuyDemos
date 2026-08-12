
module segm7x4(
	input[15:0] val16,

	output[7:0] hex0,
	output[7:0] hex1,
	output[7:0] hex2,
	output[7:0] hex3
);

wire[7:0] segm7[16];
assign segm7[0] = 8'b11000000;
assign segm7[1] = 8'b11111001;
assign segm7[2] = 8'b10100100;
assign segm7[3] = 8'b10110000;
assign segm7[4] = 8'b10011001;
assign segm7[5] = 8'b10010010;
assign segm7[6] = 8'b10000010;
assign segm7[7] = 8'b11111000;
assign segm7[8] = 8'b10000000;
assign segm7[9] = 8'b10010000;
assign segm7[10] = 8'b10001000;// A
assign segm7[11] = 8'b10000011;// B
assign segm7[12] = 8'b11000110;// C
assign segm7[13] = 8'b10100001;// D
assign segm7[14] = 8'b10000110;// E
assign segm7[15] = 8'b10001110;// F
//assign segm7[10] = 8'b10000000;// -

assign hex0[7:0] = segm7[val16 & 15];
assign hex1[7:0] = segm7[(val16 >> 4) & 15];
assign hex2[7:0] = segm7[(val16 >> 8) & 15];
assign hex3[7:0] = segm7[(val16 >> 12) & 15];

endmodule