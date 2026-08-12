
module C3PLL_top (
	input clk1,
	input clk2,
	
	output clk1o,
	output clk2o,
	output trg1o,
	output trg2o
);

wire q1, q2;
wire and7400;
assign and7400 = ~(trg1o & trg2o);

d_flip_flop_7474 d7474_1 (
    .d(0),
    .clk(clk1),
    .set_n(and7400),
    .reset_n(1),
    .q(q1),
    .q_n(trg1o)
);

d_flip_flop_7474 d7474_2 (
    .d(0),
    .clk(clk2),
    .set_n(and7400),
    .reset_n(1),
    .q(q2),
    .q_n(trg2o)
);


endmodule
