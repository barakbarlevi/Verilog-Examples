// Count up on each rising edge of a divided clock or reset signal
module clock_counter (
    input	div_clk,	// Divided clock signal
    input	rst,		
    output  reg [3:0]   led	// Why reg? we want to connect these lines to the D flip-flops.
				// They'll be a part of a procedural assignment. Also, see: https://youtu.be/LwQsyeuf9Sk?t=416
);

    // Count up on (divided) clock rising edge or reset on button push
    always @ (posedge div_clk or posedge rst) begin	
        if (rst == 1'b1) begin
            led <= 4'b0;
        end else begin
            led <= led + 1'b1;	// We are using <= because this is all registered. If it was a wire, we could have potentially
				// connected a low line to a high line and that's bad. <= procedural assignment says: read the 
				// 4-bit value on the led bus, add 1 to it, and then store it back. It's all registered.
				// It's not trivial that "+" works here. The synthesis tool knows how to handle basic addition.
				// The synthesis tool creates some kind of adder circuitry. There are different ways to implement it.
        end
    end
endmodule
