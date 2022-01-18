// Title:    mux2.sv                                                           
// Author:   ryan.ridley@okstate.edu
// Date:     9 Sep 2021                                                             
// Modified: 18 Jan 2022                                                        
// Purpose:  2-1 Multiplexor

module mux2 #(parameter WIDTH = 8)
   (input  logic [WIDTH-1:0] d0, d1, 
    input  logic             s, 
    output logic [WIDTH-1:0] y);

   assign y = s ? d1 : d0;
endmodule // mux2

