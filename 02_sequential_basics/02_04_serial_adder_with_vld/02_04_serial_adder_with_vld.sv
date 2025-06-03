//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module serial_adder_with_vld
(
  input  clk,
  input  rst,
  input  vld,
  input  a,
  input  b,
  input  last,
  output sum
);
  
  logic cin, p, g;
  wire cout;
  assign p = (a^b) & vld;
  assign g = a & b & vld;

  assign sum = p ^ cin;
  assign cout = g | p & cin;

  always_ff @(posedge clk) 
    if(rst | (vld&last))
      cin <= '0;
    else if (vld)
      cin <= cout;
  


endmodule
