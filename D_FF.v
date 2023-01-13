module D_FF(
    input clk, // input clock, slow clock
    input D,   // pushbotton
    output reg Q,
output reg Qbar
    );
	 
	 always @ (posedge clk)	begin
		Q <= D;
		Qbar <= !Q;
	 end
endmodule
