module score_and_wickets(
    input clk_fpga,
    input reset,
    input delivery,
    input teamSwitch,
    input [3:0] lfsr_out,
    input gameOver,
    output reg [7:0] runs,
    output reg [3:0] wickets,
    output reg [11:0] team1Data, // stores and updates teaml's runs and wickets when switch is 0
    output reg [11:0] team2Data  // stores and updates team2's runs and wickets when switch is 1 
    );
	 
	 localparam single = 16;
	 localparam double = 32;
	 localparam triple = 48;
	 localparam four = 64;
	 localparam six = 96;
	 
	 // update score after each delivery(bowl) based on cricket rule.
	 always @ (posedge clk_fpga, posedge reset)
	 begin
		if (reset)
			begin
			runs <= 0;
			wickets <= 0;
			team1Data <= 0;
			team2Data <= 0;
			end
		else if (gameOver)
			begin
			runs <= runs;
			wickets <= wickets;
			team1Data <= team1Data;
			team2Data <= team2Data;
			end
		else if(delivery)
			begin
				if((~teamSwitch) && (wickets < 10)) // increment score of team 1 
					begin
					case (lfsr_out) // pseudorandom number from linear feedback shift register
						0,1,2:	team1Data <= team1Data;              // dot balls
						3,4,5,6:	team1Data <= team1Data + single;
						7,8,9:	team1Data <= team1Data + double;
						10:		team1Data <= team1Data + triple;
						11:		team1Data <= team1Data + four;
						12:		team1Data <= team1Data + six;
						13,14:	team1Data <= team1Data;              // wide ball and no balls
						15:		team1Data <= team1Data + 1;             // wickets
					endcase
					runs <= team1Data[11:4];
					wickets <= team1Data[3:0];
					end
				else if((teamSwitch) && (wickets < 10)) // increment score of team 2
					begin
					case (lfsr_out) // pseudorandom number from linear feedback shift register
						0,1,2:	team2Data <= team2Data;			//dot balls 
						3,4,5,6:	team2Data <= team2Data + single;
						7,8,9:	team2Data <= team2Data + double;
						10:		team2Data <= team2Data + triple;
						11:		team2Data <= team2Data + four;
						12:		team2Data <= team2Data + six;
						13,14:	team2Data <= team2Data;			// wide ball and no balls
						15:		team2Data <= team2Data + 1;		//wickets 
					endcase
					runs <= team2Data[11:4];
					wickets <= team2Data[3:0];
					end
				end
			else // switching teams back and forth to check scores without a up button 
				begin
				case (teamSwitch)
				0: begin
					runs <= team1Data[11:4];
					wickets <= team1Data[3:0];
					end
				1: begin
					runs <= team2Data[11:4];
					wickets <= team2Data[3:0];
					end
				endcase
				end
	 end
endmodule
