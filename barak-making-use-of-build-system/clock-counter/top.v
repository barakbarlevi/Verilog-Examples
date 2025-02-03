// In this top module we will instantiate a clock divider module for the board's 12 MHz clock, as well as a clock counter module. This code is taken from Shawn Hymel's Github (XXXX LINK), with just a few slight variations. 

module top #(
	parameter COUNT_WIDTH = 32,
	parameter MAX_COUNT   = 6000000-1	// top can accept parameters. May be useful when intantiating from a testbench
) (
    input           clk,	//12 MHz clock
    input           rst_btn,
    output  [3:0]   led         // Not reg element!
);

    // Internal signals
    wire rst;
    //reg div_clk;
    wire div_clk;
    // Invert active-low button
    assign rst = ~rst_btn;

    // Instantiate the first clock divider module
    //clock_divider #(.COUNT_WIDTH(32), .MAX_COUNT(6000000 - 1)) div_1 (
    clock_divider #(.COUNT_WIDTH(COUNT_WIDTH), .MAX_COUNT(MAX_COUNT)) div_1 (
        .clk(clk), 
        .rst(rst), 
        .out(div_clk)
    );
    
    // Instantiate the second clock divider module
    //clock_divider div_2 (
    //    .clk(clk),
    //    .rst(rst),
    //    .out(led[1])
    //);
    
    clock_counter counter1 (
	    .div_clk(div_clk),
	    .rst(rst),
	    .led(led)
    );
                    
endmodule
