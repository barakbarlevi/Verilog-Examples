// In this top module we will instantiate a clock divider module for the board's 12 MHz clock, as well as a clock counter module.
// The code for the top and the other two modules is taken from Shawn Hymel's Github (https://github.com/ShawnHymel/introduction-to-fpga), with just a few slight variations. 

module top #(
	parameter COUNT_WIDTH = 32,
	parameter MAX_COUNT   = 6000000-1	// top can accept parameters. May be useful when intantiating from a testbench
) (
    input           clk,	// Icestick's 12 MHz clock
    input           rst_btn,
    output  [3:0]   led	  	// Delicate point: Even though the output of the clock_divider module (out) is registered
			  	// it can't be connected directly to another registered element (div_clk). We can only
			  	// connect an output of a module to a wire. https://youtu.be/0BKyiY8R5NU?t=370
);
    wire rst;
    assign rst = ~rst_btn;
    //reg div_clk;
    wire div_clk;	

    // Instantiate the first clock divider module
    clock_divider #(.COUNT_WIDTH(COUNT_WIDTH), .MAX_COUNT(MAX_COUNT)) div_1 (
        .clk(clk), 
        .rst(rst), 
        .out(div_clk)
    );
    
    // We could have instantiated a second clock divider module if we wanted to
    //clock_divider div_2 (
    //    .clk(clk),
    //    .rst(rst),
    //    .out(led[1])
    //);
    
    // Instantiate the clock counter module
    clock_counter counter1 (
	    .div_clk(div_clk),
	    .rst(rst),
	    .led(led)
    );
                    
endmodule
