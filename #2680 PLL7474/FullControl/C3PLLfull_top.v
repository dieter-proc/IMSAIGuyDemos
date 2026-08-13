
module C3PLLfull_top (
	// onboard interfaces, btns off=1 on=0 (inverted)
	input clk, // onboard 50MHz crystal osc
	input sw0, // sw0=1 decrement, sw0=0 increment
	input sw1, // sw1=1 reset phase to 0
	input btn0, // +-1
	input btn1, // +-10
	input btn2, // +-100
	
	// onboard 7segm display
	output[7:0] hex0,
	output[7:0] hex1,
	output[7:0] hex2,
	output[7:0] hex3,

	// PLL observable signals
	output clk1o, // PLL stable master clock
	output clk2o, // floating clock to compare
	output trg1o, // 74_1 output q_n
	output trg2o  // 74_2 output q_n
);

// onboard 7 segment display
segm7x4(
	.val16(segmVal),
	.hex0(hex0),
	.hex1(hex1),
	.hex2(hex2),
	.hex3(hex3),
);

// PLL engine with logic 7474, 7400
PLL74_00 pll74(
    .clk1(clk1),
    .clk2(clk2),
    .trg1o(trg1o),
    .trg2o(trg2o)
);

reg clk1, clk2;
reg[15:0] clk1pos = 0;
reg[15:0] clk2pos = 15'h3100;
reg[15:0] clk1max = 15'h6200;
reg[15:0] clk2max = 15'h6200;
wire[15:0] segmVal;
assign segmVal = clk2max;

assign clk1o = clk1;
assign clk2o = clk2;

reg[31:0] div32; // for buttons debouncing

reg[2:0] btn0clk, btn1clk, btn2clk;

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
	if (clk1pos == clk1max) begin
		clk1 <= ~clk1;
		clk1pos <= 0;
	end
	
	if (sw1) begin
		clk2pos <= clk1pos;
		clk2 <= clk1;
	end
	else
		clk2pos <= clk2pos + 1;
		
	if (clk2pos == clk2max) begin
		clk2 <= ~clk2;
		clk2pos <= 0;
	end
end


endmodule
