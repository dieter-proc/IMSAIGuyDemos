
module PLL74_00 (
	input clk1, // stable master clock
	input clk2, // floating clock to compare
	
	output trg1o, // 74_1 output q_n
	output trg2o  // 74_2 output q_n
);

// single 7400 NAND element to concat both triggers q_n outputs
wire nand1_2;
assign nand1_2 = ~(trg1o & trg2o);

d_flip_flop_7474 d7474_1 (
    .d(0),
    .clk(clk1),
    .set_n(nand1_2),
    .reset_n(1),
    .q_n(trg1o)
);

d_flip_flop_7474 d7474_2 (
    .d(0),
    .clk(clk2),
    .set_n(nand1_2),
    .reset_n(1),
    .q_n(trg2o)
);


endmodule
