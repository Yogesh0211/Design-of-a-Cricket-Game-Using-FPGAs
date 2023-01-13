module bcdDisplay(
	 input clk_fpga,			// master clock 100Mhz 
	 input [7:0] binaryRuns,	// runs from cricket game
	 input [3:0] binaryWickets,	// wickets from cricket game 
	 input inningOver,		// show Io on the display 
	 input gameOver,			// signals the end of the game 
	 input winner,			// locked in winner of the game 
	 output [3:0] an,			// drives the anodes 
	 output dp,				// decimal point on display 
	 output [6:0] seg			// drives the seven-segment cathodes
    );
	 
	 wire clk_1kHz;                            // 1kHz clock signal from slowclock_1kHz module 
	 wire [3:0] mux_out;                       // sends output of mux to display a specific seven segment parameter 
	 wire [1:0] counter_out;                   //sends output of the 2-bit counter to the mux and decoder 
	 wire [3:0] wickets, ones, tens, hundreds; // sends bcd output from converter to mux
	 
	 // binary to BCD converter 
	 binary_to_BCD b1 (binaryRuns, binaryWickets, inningOver, gameOver, winner, wickets, ones, tens, hundreds);
	 // generate a 1kHz clock from the 100MHz master clock 
	 slowClock_1kHz b2 (clk_fpga, clk_1kHz);
	 // two bit counter at 1kHz for refreshing anodes 
	 two_bit_counter b3 (clk_1kHz, counter_out);
	 //turn on one anode and turn off the other three on each 100 Hz tick of the 2-bit counter 
	 decoder2to4 b4 (counter_out, dp, an);
	 // select a bcd digit to display on the anode that is turned on 
	 mux4to1 b5 (counter_out, wickets, ones, tens, hundreds, mux_out);
	 // display the digit selected by the mux by using an equivalent 7-bit constant to drive the seven segment cathodes 
	 bcd7seg b6 (mux_out, seg);

endmodule
