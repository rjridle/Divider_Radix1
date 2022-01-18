// Title:    fsm.sv
// Author:   ryan.ridley@okstate.edu
// Date:     9 Sep 2021
// Modified: 18 Jan 2022
// Purpose:  FSM that sends control signals to divide1_top for states:
//           begin -> start -> iter -> done    

`timescale 1ps/1ps
module fsm #(parameter WIDTH=8) (clk, reset, start, err, sign, done, en, correct_en, state0);
  input logic		clk, reset, start, err, sign;

  output logic	done, en, correct_en, state0;

  typedef enum {Sbegin, Sstart, Siter, Sdone} statetype;

  statetype CURRENT_STATE, NEXT_STATE;

  logic [$clog2(WIDTH)-1:0] COUNTER, COUNTER_NEXT;


  always_ff @(posedge clk)
	  begin
	    if(reset==1'b1)
        begin
          CURRENT_STATE <= Sbegin;
          COUNTER <= 0;
        end //if(reset==1'b1)
	    else
        begin
          CURRENT_STATE <= NEXT_STATE;
          COUNTER <= COUNTER_NEXT;
        end //else
    end //always_ff@(posedge clk
  
  always_comb
    begin
      case(CURRENT_STATE)
        Sbegin:
          begin
            if (start==1'b0)
              begin
                en = 1'b0;
                state0 = 1'b0;
                done = 1'b0;
                correct_en = 1'b0;
                COUNTER_NEXT = COUNTER;
                NEXT_STATE = Sbegin;
              end // if (start==1'b0)
            else
              begin
	  			      en = 1'b1;
                state0 = 1'b0;
                done = 1'b0;
                correct_en = 1'b0;
                COUNTER_NEXT = COUNTER;
                NEXT_STATE = Sstart;
              end // else
          end // end Sbegin

        Sstart:
          begin
            en = 1'b1;
            state0 = 1'b1;
            done = 1'b0;
            correct_en = 1'b0;
            COUNTER_NEXT = COUNTER + 1'b1;
            NEXT_STATE = Siter;
          end // end Sstart
            
        Siter:
          begin
            en = 1'b1;
            state0 = 1'b0;
            done = 1'b0;
            correct_en = 1'b0;

            if (err==1'b1)
              begin
                NEXT_STATE = Sdone;
                COUNTER_NEXT = COUNTER + 1'b1;
              end
            //else if(COUNTER_NEXT == $clog2(WIDTH)-1)
            else if(COUNTER == 0)
              begin
                NEXT_STATE= Sdone;
                COUNTER_NEXT = COUNTER + 1'b1;
              end //COUNTER_NEXT==0
            else 
              begin
                NEXT_STATE = Siter;
                COUNTER_NEXT = COUNTER + 1'b1;
              end //else
          end // end Siter

        Sdone:
          begin
	  		    state0 = 1'b0;
	  		    done = 1'b1;
            en = 1'b0;
            correct_en = sign;
            NEXT_STATE = Sdone;
            COUNTER_NEXT = 0;
          end // end Sdone

	  	  default:
          begin
	  		    en = 1'b1;
	  		    state0 = 1'b1;
	  		    done = 1'b0;
            correct_en = 1'b0;
	  		    NEXT_STATE = Sbegin;
            COUNTER_NEXT = 0;
	  		  end // defualt
        endcase // case(CURRENT_STATE)
    end // always_comb
endmodule // fsm
