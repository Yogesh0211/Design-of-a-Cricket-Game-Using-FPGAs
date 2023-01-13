module two_bit_counter(
	 input clk,         // input clock 
	 output reg [1:0] Q // 2-bit register
    );
	 
	 /* on each positive edge of the input clock, count up from 0 to 3, 
	 and wrap around from 3 back to 0, with the 2 bit sized register 9
	 */
	 always @ (posedge clk)	begin
	 Q <= Q + 1'b1; 
	 end
	 
endmodule
