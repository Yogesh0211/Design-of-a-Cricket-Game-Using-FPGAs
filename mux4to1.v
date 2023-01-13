module mux4to1(
	 input [1:0] sel, 
	 input [3:0] A,B,C,D, 
	 output [3:0] Y
    );
	 
	 //selector switches decide what data at the input datalines go through to the output (Y). 
	 assign Y = (sel==0)?A : (sel==1)?B : (sel==2)?C : D;
	 
endmodule
