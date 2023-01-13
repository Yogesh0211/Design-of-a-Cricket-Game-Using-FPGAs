module decoder2to4(
	 input [1:0] en, 
	 output reg dp, 
	 output reg [3:0] an
    );
	 
	 // cycle through the four anodes using en (output of 2 bit counter) 
	 always@ (en)	begin 
		 case (en) 
		 0: begin
			 an = 4'b1110; 
			 dp = 1'b1;
			 end 
		 1: begin
			 an = 4'b1101; 
			 dp = 1'b0; //turn on the active low decimal point after anode ANI
			 end 
		 2: begin
			 an = 4'b1011; 
			 dp = 1'b1;
			 end 
		 3: begin
			 an = 4'b0111; 
			 dp = 1'b1;
			 end 
		 endcase 
	 end
endmodule

