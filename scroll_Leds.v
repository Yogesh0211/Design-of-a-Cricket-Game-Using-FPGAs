module scroll_Leds(
    input clk_fpga,
    output reg [7:0] led
    );
	 
	 wire clk_10Hz; // 10Hz signal from slow clock
	 
	 //shift an led every rising edge 
	 always @ (posedge clk_10Hz)	begin 
		 if (led == 8'hff)
			led <= 8'hfe; // reset to 8'b1111 1110 
		 else
			led <= {led[6:0], 1'b1}; //shift the rightmost unlit led in 8'hfe to the left 
	 end
	 slowClock_10Hz c0 (clk_fpga, clk_10Hz);

endmodule
