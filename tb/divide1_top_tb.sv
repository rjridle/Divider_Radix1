// Title:    divide1_top_tb.sv
// Author:   ryan.ridley@okstate.edu
// Date:     9 Sep 2021 
// Modified: 18 Jan 2022
// Purpose:  Testbench for simulating divide1 module

`timescale 1ns/1ps
module tb;
  
  parameter WIDTH = 8;

  logic [WIDTH-1:0] dividen, divisor, Q, R, Qcomp, Rcomp;

  logic             clk, reset, start, done, sign, err;

  divide1_top #(WIDTH) dut (dividen, divisor, clk, reset, start, Q, R, done, sign, err);

  initial 
    begin
      clk = 1'b0;
      forever #5 clk = ~clk;
    end

  initial
    begin
      #0  start   = 1'b0;
      #0  reset   = 1'b1;
      #0  dividen = -53;
      #0  divisor = 5;
      #15 reset   = 1'b0;
      #5  start   = 1'b1;
      #20 start   = 1'b0;
    end

  always @ (posedge clk)
    begin
      if (done == 1)
        begin
          $display("SIMULATION SUCCEEDED");
          $display("********************");
          $display("QUOTIENT = %d", $signed(Q));
          $display("REMAINDER = %d", $signed(R));
          Qcomp = $signed(dividen)/$signed(divisor);
          Rcomp = dividen%divisor;
          $display("Q COMPARE = %d", $signed(Qcomp));
          $display("R COMPARE = %d", Rcomp);
          repeat (1)
            @ (posedge clk)
          $stop;
        end

      if (err == 1)
        begin
          $display("SIMULATION FAILED");
          $display("*****************");
          $stop;
        end
      end //always @ (posedge clk)
endmodule // tb
