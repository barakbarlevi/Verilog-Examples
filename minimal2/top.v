//**************************************************************************
//
//    Copyright (C) 2020  John Winans
//
//    This library is free software; you can redistribute it and/or
//    modify it under the terms of the GNU Lesser General Public
//    License as published by the Free Software Foundation; either
//    version 2.1 of the License, or (at your option) any later version.
//
//    This library is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
//    Lesser General Public License for more details.
//
//    You should have received a copy of the GNU Lesser General Public
//    License along with this library; if not, write to the Free Software
//    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
//    USA
//
//**************************************************************************

`default_nettype none

/**
* This will turn on led1 when btn1 is pressed.
**************************************************************************/
module top (
    input wire btn1,    	// a single-bit input signal called btn1
    output wire led1    	// a single-bit output signal called led1
    );

    wire btn1_pu;

    SB_IO #(
        .PIN_TYPE(6'b0000_01),  // output = 0, input = 1
        .PULLUP(1'b1)           // enable the pullup = 1
    ) btn1_pullup (
        .PACKAGE_PIN(btn1),  	// the physical pin number with the pullup on it
        .D_IN_0(btn1_pu)     		// an internal wire for this pin
    );

    assign led1 = btn1_pu;		// connect the btn1 input to the led1 output

endmodule
