//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module formula_2_pipe_using_fifos
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

    wire               b_fifo_push, b_fifo_pop;
    wire [31:0]        b_fifo_read_data;
    wire               b_fifo_empty, b_fifo_full;

    wire               a_fifo_push, a_fifo_pop;
    wire [31:0]        a_fifo_read_data;
    wire               a_fifo_empty, a_fifo_full;

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

    flip_flop_fifo_with_counter #(
        .width (32),
        .depth (16))
        fifo_b 
    (
        .clk         ( clk             ),
        .rst         ( rst             ),
        .push        ( b_fifo_push     ),
        .pop         ( b_fifo_pop      ),
        .write_data  ( b               ),
        .read_data   ( b_fifo_read_data ),
        .empty       ( b_fifo_empty    ),
        .full        ( b_fifo_full     )
    );

    assign b_fifo_push = arg_vld && !b_fifo_full;
    assign b_fifo_pop  = isqrt_c_vld && !b_fifo_empty;

    flip_flop_fifo_with_counter #(
        .width (32),
        .depth (33))

    fifo_n 
    (
        .clk         ( clk             ),
        .rst         ( rst             ),
        .push        ( a_fifo_push     ),
        .pop         ( a_fifo_pop      ),
        .write_data  ( a               ),
        .read_data   ( a_fifo_read_data ),
        .empty       ( a_fifo_empty    ),
        .full        ( a_fifo_full     )
    );

    assign a_fifo_push = arg_vld && !a_fifo_full;
    assign a_fifo_pop  = isqrt_bc_vld && !a_fifo_empty;

    always_ff @(posedge clk) begin
        if (rst) begin
            arg_c_vld  <= '0;
            arg_bc_vld <= '0;
        end 
        else begin
            arg_c_vld  <= isqrt_c_vld; 
            arg_bc_vld <= isqrt_bc_vld;
        end
    end

    logic [31:0] sum_bc, sum_abc;

    assign sum_bc  = b_fifo_read_data + isqrt_c;
    assign sum_abc = a_fifo_read_data + isqrt_bc;

    always_ff @(posedge clk) begin
        if (isqrt_c_vld)
            arg_bc <= sum_bc;
    
        if (isqrt_bc_vld)
            arg_abc <= sum_abc;
    end

    assign res     = isqrt_abc;
    assign res_vld = isqrt_abc_vld;

endmodule
