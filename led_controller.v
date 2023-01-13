module led_controller(
	 input clk_fpga,
	 input reset,
	 input teamSwitch,
	 input delivery,
	 input [3:0] lfsr_out,
	 input inningOver,
	 input gameOver,
	 output reg [7:0] leds,
	 output reg [6:0] team1Balls,
	 output reg [6:0] team2Balls
	 );
	 
	 wire [7:0] scroll; // sends values for scrolling leds from scrollLeds module when the game is over
	 
	 // count up the balls and update the leds 
	 always @ (posedge clk_fpga, posedge reset)	begin 
		 if (reset)
			begin 
			leds <= 0; 
			team1Balls <= 0; 
			team2Balls <= 0;
			end 
		 else if(gameOver)
			leds <= scroll; // use scrolling Leds from scrollLeds module when the game is over 
		 else if(delivery)
			begin 
			if((teamSwitch == 0) && (inningOver == 0)) // increment balls only if teaml's inning is not over
				begin 
				case (lfsr_out)                              // pseudorandom number from linear feedback shift register
					13,14: team1Balls <= team1Balls;       //wide ball and no ball
					default: team1Balls <= team1Balls + 1; //ones, twos, threes, fours, sixes, dotballs 
				endcase
				leds <= team1Balls;
				end 
			else if ((teamSwitch) && (inningOver == 0)) // increment balls only if team2's inning is not over
				begin 
				case (lfsr_out)                              // pseudorandom number from linear feedback shift register
					13,14: team2Balls <= team2Balls;       //wide ball and no ball
					default: team2Balls <= team2Balls + 1; //ones, twos, threes, fours, sixes, dotballs 
				endcase
				leds <= team2Balls;
				end 
			end 
		 else if(~teamSwitch)
				leds <= team1Balls; 
		 else
				leds <= team2Balls; 
	 end
	 // supplies a signal of led values called 'scroll' to the block above. for use when the game is over 
	 scroll_Leds g5 (clk_fpga, scroll);
	 
endmodule
