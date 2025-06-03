//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module detect_4_bit_sequence_using_fsm
(
  input  clk,
  input  rst,
  input  a,
  output detected
);

  enum logic[2:0]
  {
     IDLE = 3'b000,
     F1   = 3'b001,
     F0   = 3'b010,
     S1   = 3'b011,
     S0   = 3'b100
  }
  state, new_state;

  always_comb
  begin
    new_state = state;

    case (state)
      IDLE: if (  a) new_state = F1;
      F1:   if (~ a) new_state = F0;
      F0:   if (  a) new_state = S1;
            else     new_state = IDLE;
      S1:   if (~ a) new_state = S0;
            else     new_state = F1;
      S0:   if (  a) new_state = S1;
            else     new_state = IDLE;
    endcase

  end

  assign detected = (state == S0);

  always_ff @ (posedge clk)
    if (rst)
      state <= IDLE;
    else
      state <= new_state;

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module detect_6_bit_sequence_using_fsm
(
  input  clk,
  input  rst,
  input  a,
  output detected
);
 
  enum logic[2:0] 
  {
    IDLE = 3'b000,
    F1   = 3'b001,
    S1   = 3'b010,
    F0   = 3'b011,
    S0   = 3'b100,
    T1   = 3'b101,
    FR1  = 3'b110
  }
  state, new_state;

  always_comb 
    begin 
      new_state = state;

      case (state) 
        IDLE: if (a)  new_state = F1;
        F1:   if (a)  new_state = S1;
              else    new_state = IDLE;
        S1:   if (~a) new_state = F0;
              
        F0:   if (~a) new_state = S0;
              else    new_state = F1;
        S0:   if (a)  new_state = T1;
              else    new_state = IDLE;
        T1:   if (a)  new_state = FR1;
              else    new_state = IDLE;
        FR1:  if (~a) new_state = F0;
              else    new_state = S1;
      endcase
    end 
  

     assign detected = (state == FR1);

     always_ff @ (posedge clk)
       if (rst)
        state <= IDLE;
       else 
        state <= new_state;

endmodule
