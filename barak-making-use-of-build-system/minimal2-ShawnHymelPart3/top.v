// Module: button 0 lights up 2 LEDs, button 0 and button 1 light up another 
module top (
	input	[1:0] pmod,
	output 	[2:0] led
);
	wire not_pmod_0;
	assign not_pmod_0 = ~pmod[0];
	assign led[1:0] = {2{not_pmod_0}};
	assign led[2] = not_pmod_0 & ~pmod[1];
endmodule

