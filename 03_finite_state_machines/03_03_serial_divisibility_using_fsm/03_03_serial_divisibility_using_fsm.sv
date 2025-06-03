//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module serial_divisibility_by_3_using_fsm
(
  input  clk,
  input  rst,
  input  new_bit,
  output div_by_3
);

  enum logic[1:0]
  {
     mod_0 = 2'b00,
     mod_1 = 2'b01,
     mod_2 = 2'b10
  }
  state, new_state;

  always_comb
  begin
    new_state = state;

    case (state)
      mod_0 : if(new_bit) new_state = mod_1;
              else        new_state = mod_0;
      mod_1 : if(new_bit) new_state = mod_0;
              else        new_state = mod_2;
      mod_2 : if(new_bit) new_state = mod_2;
              else        new_state = mod_1;
    endcase

  end

  assign div_by_3 = state == mod_0;

  always_ff @ (posedge clk)
    if (rst)
      state <= mod_0;
    else
      state <= new_state;

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module serial_divisibility_by_5_using_fsm
(
  input  clk,
  input  rst,
  input  new_bit,
  output div_by_5
);

  enum logic[2:0] 
  {
     mod_0 = 3'b000,
     mod_1 = 3'b001,
     mod_2 = 3'b010,
     mod_3 = 3'b011,
     mod_4 = 3'b100
  }
  state, new_state;

  always_comb
  begin
    new_state = state;

    case (state)
    mod_0: if (new_bit) new_state = mod_1;
           else         new_state = mod_0;
    mod_1: if (new_bit) new_state = mod_3;
           else         new_state = mod_2;
    mod_2: if (new_bit) new_state = mod_0;
           else         new_state = mod_4;
    mod_3: if (new_bit) new_state = mod_2;
           else         new_state = mod_1;
    mod_4: if (new_bit) new_state = mod_4;
           else         new_state = mod_3;
    endcase

  end

  assign div_by_5 = state == mod_0;

  always_ff @ (posedge clk)
    if (rst)
      state <= mod_0;
    else 
      state <= new_state;

endmodule
