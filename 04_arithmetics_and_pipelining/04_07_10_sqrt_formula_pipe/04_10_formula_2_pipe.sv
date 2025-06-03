//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module formula_2_pipe
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

    logic [15:0] isqrt_c, isqrt_bc, isqrt_abc; 
    logic [31:0] arg_bc, arg_abc;
    logic isqrt_c_vld, isqrt_bc_vld, isqrt_abc_vld;
    logic arg_c_vld, arg_bc_vld;

    isqrt isqrt_1 
    (
        .clk   ( clk           ), 
        .rst   ( rst           ), 
        .x_vld ( arg_vld       ), 
        .x     ( c             ), 
        .y_vld ( isqrt_c_vld   ), 
        .y     ( isqrt_c       )
    );

    isqrt isqrt_2 
    (
        .clk   ( clk           ), 
        .rst   ( rst           ), 
        .x_vld ( arg_c_vld     ), 
        .x     ( arg_bc        ), 
        .y_vld ( isqrt_bc_vld  ), 
        .y     ( isqrt_bc      )
    );

    isqrt isqrt_3 
    (
        .clk   ( clk           ), 
        .rst   ( rst           ), 
        .x_vld ( arg_bc_vld    ), 
        .x     ( arg_abc       ), 
        .y_vld ( isqrt_abc_vld ), 
        .y     ( isqrt_abc     )
    );

    logic [31:0] isqrt_sum; 
    logic [31:0] res_reg;
    logic res_vld_reg; 

    logic [31:0] a_shift_reg, b_shift_reg;

    shift_register_with_valid #(32, 16) shft_reg_n
    (
        .clk      ( clk         ),
        .rst      ( rst         ),
        .in_vld   ( arg_vld     ),
        .in_data  ( b           ),
        .out_vld  (             ),
        .out_data ( b_shift_reg )
    );

    shift_register_with_valid #(32, 33) shft_reg_2n_1
    (
        .clk      ( clk         ),
        .rst      ( rst         ),
        .in_vld   ( arg_vld     ),
        .in_data  ( a           ),
        .out_vld  (             ),
        .out_data ( a_shift_reg )
    ); 

    logic [31:0] sum_bc, sum_abc;

    assign sum_bc = b_shift_reg + isqrt_c;
    assign sum_abc = a_shift_reg + isqrt_bc;
    

    always_ff @ (posedge clk)
        if (rst) begin
            arg_c_vld  <= '0;
            arg_bc_vld <= '0;
        end
        else begin
            arg_c_vld  <= isqrt_c_vld; 
            arg_bc_vld <= isqrt_bc_vld;
        end

    always_ff @ (posedge clk)
        if (isqrt_c_vld)
            arg_bc <= sum_bc;
    
    always_ff @ (posedge clk)
        if (isqrt_bc_vld)
            arg_abc <= sum_abc;

    
    assign res = isqrt_abc; 
    assign res_vld = isqrt_abc_vld;

endmodule
