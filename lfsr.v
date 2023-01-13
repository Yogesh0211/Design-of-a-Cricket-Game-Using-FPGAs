module lfsr(
    input clk_fpga, 
	 input reset,
    output [3:0] lfsr_out
    );
	 
	 reg [5:0] shift;
	 wire xor_sum;
	 
	 assign xor_sum = shift[1] ^ shift[4]; // feedback taps
	 always @ (posedge clk_fpga)	begin
		if(reset)
			shift <= 6'b111111;
		else
			shift <= {xor_sum, shift[5:1]};  // shift right
	 end
	 assign lfsr_out = shift[3:0]; // output of LFSR 
	 
endmodule

