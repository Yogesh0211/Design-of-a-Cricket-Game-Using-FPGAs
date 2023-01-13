module Cricket(
    input clk_fpga,   // 100MHZ Nexsys3 master clock 
    input reset,      // center push button used as reset 
    input btnU,       // up push button 
    input sw,         // switch between Team 1 and Team 2 
    output dp,        // use the third decimal point as a separator 
    output [6:0] seg, // goes to anode ports defined in constraints 
    output [3:0] an,  // goes to seven seg cathodes defined in constraints 
    output [7:0] led  // drive the leds
    );
	 
	 wire delivery;            // debounced up button press 
	 wire [7:0] binaryRuns;    // runs from game 
	 wire [3:0] binaryWickets; // wickets from game 
	 wire inningOver;          // signal from match to bcd display to show 10 (inning over) on display 
	 wire gameOver;            // signal from match to bcd display to lock in winner on display 
	 wire winner;              // signal from match to bcd display to select winner to display
	 
	 // debounces the up push button 
	 debounce d0(clk_fpga, btnU, delivery);
	 // A single game of cricket 
	 cricketGame g0(clk_fpga, reset, delivery, sw, binaryRuns, binaryWickets, led, inningOver, gameOver, winner);
	 // converts and displays the runs on the three leftmost digits and the wickets on the last fourth digit, separated by a decimal point. 
	 bcdDisplay b0(clk_fpga, binaryRuns, binaryWickets, inningOver, gameOver, winner, an, dp, seg);
	 
endmodule