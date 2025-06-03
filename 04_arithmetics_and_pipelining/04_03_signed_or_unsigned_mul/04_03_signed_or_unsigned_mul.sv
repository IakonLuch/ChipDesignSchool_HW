//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module signed_mul_4
(
  input  signed [3:0] a, b,
  output signed [7:0] res
);

  assign res = a * b;

endmodule

module unsigned_mul
# (
  parameter n = 8
)
(
  input  [    n - 1:0] a, b,
  output [2 * n - 1:0] res
);

  assign res = a * b;

endmodule

module signed_or_unsigned_mul
# (
  parameter n = 8
)
(
  input  [    n - 1:0] a, b,
  input                signed_mul,
  output [2 * n - 1:0] res
);

 // logic [2 * n - 2:0] res_unsigned;
 // logic res_signed;
//
 // assign res_sign = a[n - 1] ^ b[n - 1];
 // assign res_unsigned = a[n - 2:0] * b[n - 2:0];
//
 // assign res = {res_signed, res_unsigned};
//

  logic [2 * n - 1:0] a_extended, b_extended;

  assign a_extended = signed_mul ? { {n{a[n-1]}}, a } : { {n{1'b0}}, a };
  assign b_extended = signed_mul ? { {n{b[n-1]}}, b } : { {n{1'b0}}, b };

  assign res = a_extended * b_extended;

endmodule
