
module C3PLLfull_top (
	input clk,
	input sw0,
	input sw1,
	input btn0,
	input btn1,
	input btn2,
	
	output clk1o,
	output clk2o,
	output trg1o,
	output trg2o,
	
	output[7:0] hex0,
	output[7:0] hex1,
	output[7:0] hex2,
	output[7:0] hex3
);

segm7x4(
	.val16(segmVal),
	.hex0(hex0),
	.hex1(hex1),
	.hex2(hex2),
	.hex3(hex3),
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

reg clk1, clk2;
reg[15:0] clk1pos = 0;
reg[15:0] clk2pos = 300;
reg[15:0] clk1max = 15'h6200;
reg[15:0] clk2max = 15'h6200;
wire[15:0] segmVal;
assign segmVal = clk2max;

assign clk1o = clk1;
assign clk2o = clk2;

reg[31:0] div32;

reg[2:0] btn0clk, btn1clk, btn2clk;
wire[15:0] clk2addVal;
wire[15:0] clk2add;

always @(posedge div32[20])
begin
	if (!btn0 && !btn0clk[2]) btn0clk <= btn0clk + 1; else btn0clk <= 0;
	if (!btn1 && !btn1clk[2]) btn1clk <= btn1clk + 1; else btn1clk <= 0;
	if (!btn2 && !btn2clk[2]) btn2clk <= btn2clk + 1; else btn2clk <= 0;
	if (btn0clk[2]) clk2max <= clk2max + (1 * sw0 ? -1 : 1);
	if (btn1clk[2]) clk2max <= clk2max + (15'hA * (sw0 ? -1 : 1));
	if (btn2clk[2]) clk2max <= clk2max + (15'h64 * (sw0 ? -1 : 1));
end

always @(posedge clk)
begin
	div32 <= div32 + 1;
	clk1pos <= clk1pos + 1;
	if (clk1pos == clk1max) begin clk1 <= ~clk1; clk1pos <= 0; end
	if (sw1) begin clk2pos <= clk1pos; clk2 <= clk1; end
	else clk2pos <= clk2pos + 1;
	if (clk2pos == clk2max) begin clk2 <= ~clk2; clk2pos <= 0; end
end


endmodule
