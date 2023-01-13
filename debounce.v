module debounce(
    input clk_fpga,		// clock signal input button,
    input button,			// input button 
    output debounced_button	// debounced button
    );
	 
	 wire Q1;		// output of first D flip flop and input of second D flip flop
	 wire Q2;		// output of second D flip flop 
	 wire Q2_bar;	// inverted output of second D flip flop
	 
	 /*Most switches exhibit bounce rates at over 100Hz (under 10 ms). 
	 For seemingly instantaneous responses, it is reasonable to pick a debounce period of 20ms (50Hz) - 50ms (20Hz). 
	 We debounce at 100ms (10Hz) to make use of a module made to scroll leds at 10Hz
	 */
	 slowClock_10Hz u1(clk_fpga, clk_10Hz);	// 10Hz slow clock
	 D_FF d1(clk_10Hz, button, Q1);		// first flip flop 
	 D_FF d2(clk_10Hz, Q1, Q2);			// second flip flop
	 
	 assign Q2_bar = ~Q2;				// invert output of second D flip flop
	 assign debounced_button = Q1 & Q2_bar;	// send out debounced button

endmodule
