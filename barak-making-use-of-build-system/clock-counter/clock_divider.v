// Clock divider
module clock_divider #(
    parameter                     COUNT_WIDTH = 24,		// Bus width for local counter
    parameter [COUNT_WIDTH-1:0]   MAX_COUNT   = 6000000 - 1	// Maximum value of counter 
) (
    input       clk,
    input       rst,
    output  reg out	// This is div_clk, the divided clock output. out needs to be registered
			// because we're going to use a clock to control it and store its signal level. https://youtu.be/0BKyiY8R5NU?t=175
);
    wire rst;
    reg [COUNT_WIDTH:0] count;
    
    // Clock divider
    always @ (posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            count <= 0;
            out <= 0;
        end else if (count == MAX_COUNT) begin
            count <= 0;
            out <= ~out;	// Toggle the line ata divided rate given clk input
        end else begin
            count <= count + 1;
        end
    end
    
endmodule
