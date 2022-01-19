// Title:    adder.sv
// Author:   ryan.ridley@okstate.edu
// Date:     9 Sep 2021                                                             
// Modified: 18 Jan 2022                                                        
// Purpose:  Full Adder

module adder #(parameter WIDTH=8) 
   (input logic [WIDTH-1:0] a, b,
    output logic [WIDTH-1:0] y);
   
   assign y = a + b;
endmodule // adder

