// Title:    flopenr.sv
// Author:   ryan.ridley@okstate.edu
// Date:     9 Sep 2021
// Modified: 18 Jan 2022                                                        
// Purpose:  Enable-Reset DFF

`timescale 1ps/1ps
module flopenr #(parameter WIDTH = 8)
   (input  logic             clk, reset, en,
    input  logic [WIDTH-1:0] d, 
    output logic [WIDTH-1:0] q);

   always_ff @(posedge clk, posedge reset)
     if (reset)   q <= #10 0;
     else if (en) q <= #10 d;
endmodule // flopenr

