// Title:    mux3.sv                                                           
// Author:   ryan.ridley@okstate.edu
// Date:     9 Sep 2021                                                             
// Modified: 18 Jan 2022                                                        
// Purpose:  3-1 Multiplexor

module mux3 #(parameter WIDTH = 8)
   (input  logic [WIDTH-1:0] d0, d1, d2,
    input  logic [1:0]       s, 
    output logic [WIDTH-1:0] y);

   assign y = s[1] ? d2 : (s[0] ? d1 : d0);

endmodule // mux3
