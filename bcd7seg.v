module bcd7seg(
	 input [3:0] y, 
	 output reg [6:0] segs
    );
	 
	 //display 7-seg equivalent of 4-bit digit y 
	 always @ (y) 
	 begin 
	 case (y)
	 0: segs = 7'b100_0000;  //0 
	 1: segs = 7'b111_1001;  //1 
	 2: segs = 7'b010_0100;  //2 
	 3: segs = 7'b011_0000;  //3 
	 4: segs = 7'b001_1001;  //4 
	 5: segs = 7'b001_0010;  //5 
	 6: segs = 7'b000_0010;  //6 
	 7: segs = 7'b111_1000;  //7 
	 8: segs = 7'b000_0000;  //8 
	 9: segs = 7'b001_0000;  //9 
	 10: segs = 7'b000_1000; //A 
	 11: segs = 7'b000_0011; //B 
	 12: segs = 7'b101_1111; //' using a left apostrophe instead of C 
	 13: segs = 7'b100_1111; //I using I to help display '10' instead of D 
	 14: segs = 7'b111_1101; //' using a right apostrophe instead of E
	 15: segs = 7'b000_0111; //t using t instead of f to show the winning team as tol or t02 
	 endcase 
	 end
endmodule
