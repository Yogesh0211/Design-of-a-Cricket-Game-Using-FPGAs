module binary_to_BCD(
    input [7:0] binaryRuns,
    input [3:0] binaryWickets,
    input inningOver,
    input gameOver,
    input winner,
    output reg [3:0] wickets, ones, tens, hundreds
    );
	 
	 reg [7:0] data; //temporarily store binaryRuns for calculations
	 always@ (binaryRuns, binaryWickets, inningOver, gameOver, winner)	begin 
	 if(~gameOver) // still playing
		begin 
		if(inningOver)
			begin 
			hundreds <= 4'b1100; // ', see bcd7seg module in bcdDisplay 
			tens <= 4'b1101;     // I 
			ones <= 4'b0000;     // O
			wickets <= 4'b1110;  // '
			end 
		else
			begin 
			data = binaryRuns; 
			hundreds <= data / 100; 
			data = data % 100; 
			tens <= data / 10; 
			ones <= data % 10;
			wickets <= (binaryWickets % 10);
			end
		end 
	 else //game is over : lock the winner on the screen till the reset button is hit
		begin 
		case (winner) //t010 or t020. f is swapped for t in bcd7seg 
		0: begin      //t010
			hundreds <= 4'b1111; 
			tens <= 4'b0000; 
			ones <= 4'b0001; 
			wickets <= 4'b0000; 
			end 
		1: begin      //t020 
			hundreds <= 4'b1111; 
			tens <= 4'b0000; 
			ones <= 4'b0010; 
			wickets <= 4'b0000;
			end 
		endcase 
		end
	 end
endmodule
