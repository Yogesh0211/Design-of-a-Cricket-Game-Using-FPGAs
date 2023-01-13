module score_comparator(
    input clk_fpga,
    input reset,
	 input [11:0] team1Data, 
	 input [11:0] team2Data, 
	 input [6:0] team1Balls, 
	 input [6:0] team2Balls, 
	 input [3:0] wickets, 
	 input [7:0] balls, 
	 output reg inningOver, 
	 output reg gameOver, 
	 output reg winnerLocked
    );
	 
	 // if the currently selected team has 120 balls or 10 wickets, their inning is complete, so signal bcdDisplay to show IO on screen 
	 always @ (posedge clk_fpga)	begin 
		 if((wickets >= 10) || (balls >= 120))
			inningOver <= 1; 
		 else
			inningOver <= 0; 
	 end
	 
	 // if both teams either reach 120 balls or have lost 10 wickets, end the game 
	 always @ (posedge clk_fpga, posedge reset)	begin 
		 if (reset)
			gameOver <= 0; 
		 else if(((team1Data[3:0] >= 10) || (team1Balls >= 120)) && ((team2Data[3:0] >= 10) || (team2Balls >= 120)))
			gameOver <= 1; 
		 else
			gameOver <= gameOver;
	 end
	 
	 // on rising edge of gameover, lock in the winner 
	 always @ (posedge gameOver)	begin 
		 if (team1Data[11:4] > team2Data[11:4]) // most runs on gameover wins
			winnerLocked <= 0; // team 1 wins 
		 else
			winnerLocked <= 1; // team 2 wins
	 end
	 
endmodule
