# Episode #2680

PLL Phase Detector using 7474 
https://www.youtube.com/watch?v=r38NwxkmWgA

Best for testing and observation with oscilloscope, not in simulation testbench, as effect appears in longtime frequency changes and phase drift.

Contains 2 subprojects, initially targeted to Altera Quartus II 13 and implemented with Terrassic DE0 Cyclone III board.
https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=56&No=364

# FullControl 
* project with all whistles, no external function generators needed, only scope needed for observation
* maintains master clock PLL clock and separate floating frequency to compare
* from 5 input buttons/switches drifts and changes PLL compared floating frequency and phase
* outputs 7474 outputs and input frequencies for scope observation
* displays current floating frequency counter value on 4 digit 7 segment
* uses about 200 marcocells
	
# PllOnly
* minimal 7474-7400 implementation
* uses about 3 macrocells
* lacks frequency comparing

For fun idea, could be added some frequency comparing, like counters, which increases a lot macrocells count, but result might be full PLL with single PWM output for full and VCO frequency/phase control.
