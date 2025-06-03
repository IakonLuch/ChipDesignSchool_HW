//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module formula_1_pipe
(
    input         clk,
    input         rst,

    input         arg_vld,
    input  [31:0] a,
    input  [31:0] b,
    input  [31:0] c,

    output        res_vld,
    output [31:0] res
);
    
    logic [15:0] isqrt_a, isqrt_b, isqrt_c;
    logic [31:0] isqrt_sum;
    logic isqrt_a_vld, isqrt_b_vld, isqrt_c_vld, isqrt_sum_vld;

    isqrt isqrt1
    (
        .clk   ( clk         ),
        .rst   ( rst         ),
        .x_vld ( arg_vld     ),
        .x     ( a           ),
        .y_vld ( isqrt_a_vld ),
        .y     ( isqrt_a     )
    );

        isqrt isqrt2
    (
        .clk   ( clk         ),
        .rst   ( rst         ),
        .x_vld ( arg_vld     ),
        .x     ( b           ),
        .y_vld ( isqrt_b_vld ),
        .y     ( isqrt_b     )
    );

        isqrt isqrt3
    (
        .clk   ( clk         ),
        .rst   ( rst         ),
        .x_vld ( arg_vld     ),
        .x     ( c           ),
        .y_vld ( isqrt_c_vld ),
        .y     ( isqrt_c     )
    );

    assign isqrt_sum_vld = isqrt_a_vld & isqrt_b_vld & isqrt_c_vld;
    assign isqrt_sum = isqrt_a + isqrt_b + isqrt_c;

    logic  res_vld_reg;
    logic  [31:0] res_reg;

    always_ff @ (posedge clk)
        if (rst)
            res_vld_reg <= '0;
        else 
            res_vld_reg <= isqrt_sum_vld;

    always_ff @ (posedge clk)
        if (isqrt_sum_vld)
            res_reg <= isqrt_sum;

    assign res_vld = res_vld_reg;
    assign res = res_reg;


endmodule
