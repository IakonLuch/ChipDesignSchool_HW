//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module posedge_detector (input clk, rst, a, output detected);

  logic a_r;

  always_ff @ (posedge clk)
    if (rst)
      a_r <= '0;
    else
      a_r <= a;

  assign detected = ~ a_r & a;

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module one_cycle_pulse_detector (input clk, rst, a, output detected);
  
  logic a_r;
  logic a_r2;
  
  always_ff @(posedge clk)
    if (rst)
      begin
        a_r <= '0;
        a_r2 <= '0;
      end
    else begin
      a_r <= a;
      a_r2 <= a_r;
    end

  assign detected = ~a & a_r & ~a_r2;


endmodule
