//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module add
(
  input  [3:0] a, b,
  output [3:0] sum
);

  assign sum = a + b;

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module signed_add_with_saturation
(
  input  [3:0] a, b,
  output [3:0] sum
);

    logic sel;
    logic overflow;
    logic [3:0] sum1;
    logic [3:0] sum2;

    add a1 (.a(a)    ,
          .b(b)    ,
          .sum(sum1));
    
    always_comb begin

      sel = ((a[3] & b[3] & ~sum1[3]) & ~(~a[3] & ~b[3] & sum1[3]));
      overflow = ((a[3] & b[3] & ~sum1[3]) | (~a[3] & ~b[3] & sum1[3]));
      if (overflow)
        sum2 = sel ? 4'b1000 : 4'b0111;
      else 
        sum2 = sum1;

    end
    
    assign sum = sum2;
    
endmodule
