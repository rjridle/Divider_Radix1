// Title:    divide1_top.sv
// Author:   ryan.ridley@okstate.edu
// Date:     9 Sep 2021 
// Modified: 18 Jan 2022
// Purpose:  Radix-1 Variable Bit Restoring Divider Performs division by
//           repeated subtraction.

`timescale 1ns/1ps
module divide1_top #(parameter WIDTH=8) (dividen, divisor, clk, reset, start, Qsigned, R, done, sign, err);

  input logic [WIDTH-1:0] dividen, divisor;
  input logic clk, reset, start;

  output logic [WIDTH-1:0] Qsigned, R;
  output logic done, sign, err;

  logic [WIDTH-1:0] divisor2c, dividen_unsigned, Q, Qnext, Rnext, Qtemp, Rtemp, ext_sign;
  logic state0, en, correct_en;

  assign sign = dividen[WIDTH-1];
  assign err = (divisor==0);

  adder #(WIDTH) divisor2C (~divisor, 'b1, divisor2c);
  assign ext_sign = {WIDTH{~sign}};

  adder #(WIDTH) dividen_uns (ext_sign ^ ~dividen, {'b0,sign}, dividen_unsigned);
  adder #(WIDTH) quotient_sig (ext_sign ^ ~Qtemp, {'b0,sign}, Qsigned);

  mux3 #(WIDTH) Rnext_mux (R, 'b0, Rtemp, {correct_en||done, state0}, Rnext);
  mux3 #(WIDTH) Qnext_mux (Q, dividen_unsigned, Qsigned, {correct_en||done, state0}, Qnext);
  
  flopenr #(WIDTH) Rtemp_flopenr (clk, reset, ~correct_en||~done, Rnext, Rtemp);
  flopenr #(WIDTH) Qtemp_flopenr (clk, reset, ~correct_en||~done, Qnext, Qtemp);

  flopenr #(WIDTH) Q_flopenr (clk, reset, en, Qnext, Q);
  flopenr #(WIDTH) R_flopenr (clk, reset, en, Rnext, R);

  divide1 #(WIDTH) div (divisor2c, Q, R, Qnext, Rnext);

  fsm #(WIDTH) control (~clk, reset, start, err, sign, done, en, correct_en, state0);
endmodule // divide1_top 
