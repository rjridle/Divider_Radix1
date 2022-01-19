// Title:    Makefile
// Author:   ryan.ridley@okstate.edu
// Date:     5 Oct 2021
// Modified: 18 Jan 2022
// Purpose:  make flow for compiling and simulating divide1 module

module divide1 #(parameter WIDTH=8) (D, Q, R, Qout, Rout);
  input logic [WIDTH-1:0] D, Q, R;

  output logic [WIDTH-1:0] Qout, Rout;

  logic [WIDTH-1:0] Rtemp, Rsave, Rshift, Qshift;
  
  always @ (R or Q)
    begin
      Rshift = R << 1;
      Qshift = Q << 1;
      Rtemp = {Rshift[WIDTH-1:1], Q[WIDTH-1]};
      Rsave = Rtemp + D;
      Rout = ~(Rsave[WIDTH-1]) ? Rsave : Rtemp;
      Qout = {Qshift[WIDTH-1:1], ~Rsave[WIDTH-1]};
    end
endmodule // divide1 
