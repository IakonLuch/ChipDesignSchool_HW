//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module formula_1_pipe_aware_fsm
(
    input               clk,
    input               rst,

    input               arg_vld,
    input        [31:0] a,
    input        [31:0] b,
    input        [31:0] c,

    output logic        res_vld,
    output logic [31:0] res,

    // isqrt interface

    output logic        isqrt_x_vld,
    output logic [31:0] isqrt_x,

    input               isqrt_y_vld,
    input        [15:0] isqrt_y
);

    // Task:
    //
    // Implement a module formula_1_pipe_aware_fsm
    // with a Finite State Machine (FSM)
    // that drives the inputs and consumes the outputs
    // of a single pipelined module isqrt.
    //
    // The formula_1_pipe_aware_fsm module is supposed to be instantiated
    // inside the module formula_1_pipe_aware_fsm_top,
    // together with a single instance of isqrt.
    //
    // The resulting structure has to compute the formula
    // defined in the file formula_1_fn.svh.
    //
    // The formula_1_pipe_aware_fsm module
    // should NOT create any instances of isqrt module,
    // it should only use the input and output ports connecting
    // to the instance of isqrt at higher level of the instance hierarchy.
    //
    // All the datapath computations except the square root calculation,
    // should be implemented inside formula_1_pipe_aware_fsm module.
    // So this module is not a state machine only, it is a combination
    // of an FSM with a datapath for additions and the intermediate data
    // registers.
    //
    // Note that the module formula_1_pipe_aware_fsm is NOT pipelined itself.
    // It should be able to accept new arguments a, b and c
    // arriving at every N+3 clock cycles.
    //
    // In order to achieve this latency the FSM is supposed to use the fact
    // that isqrt is a pipelined module.
    //
    // For more details, see the discussion of this problem
    // in the article by Yuri Panchul published in
    // FPGA-Systems Magazine :: FSM :: Issue ALFA (state_0)
    // You can download this issue from https://fpga-systems.ru/fsm#state_0


    enum logic [1:0]
    {
        st_1  = 2'd0,
        st_2  = 2'd1,
        st_3  = 2'd2
    }
    state, next_state;

    always_comb
    begin
        next_state = state;

        case (state)
        st_1 : if ( arg_vld )   next_state = st_2;
        st_2 :                  next_state = st_3;
        st_3 :                  next_state = st_1;
        endcase
    end

    always_ff @ (posedge clk)
        if (rst)
            state <= st_1;
        else
            state <= next_state;


    always_comb
    begin
        isqrt_x_vld = '0;
        isqrt_x = 'x;  

        case (state)
        st_1       : 
            begin
                isqrt_x_vld = arg_vld;  
                isqrt_x = a;
            end

        st_2 : 
            begin
                isqrt_x_vld = arg_vld_reg [0]; 
                isqrt_x = b_reg;
            end

        st_3 : 
            begin
                isqrt_x_vld = arg_vld_reg [1];
                isqrt_x = c_reg_reg;
            end

        endcase
    end

    logic [1:0] arg_vld_reg; 

    always_ff @ (posedge clk)
        if (rst)
            arg_vld_reg <= '0;
        else
            arg_vld_reg <= { arg_vld_reg [0], arg_vld }; 

    logic [31:0] b_reg;
    logic [31:0] c_reg, c_reg_reg;

    always_ff @ (posedge clk)
        if (arg_vld)
            b_reg <= b;

    always_ff @ (posedge clk)
        if (arg_vld)
            c_reg <= c;
        else if (arg_vld_reg [0])
            c_reg_reg <= c_reg; 

    logic [31:0] res_reg; 
    logic [1:0] count = 2'b00;

    always_ff @ (posedge clk)
        if (rst) begin
            res_reg <= '0; 
            count <= '0;
        end

        else if (count == 2'b10) begin
            count <= '0; 
            res_reg <= '0;
        end

        else if (isqrt_y_vld) begin
            count <= count + 1'b1;
            res_reg <= res_reg + isqrt_y; 
        end

    always_comb
        if (count == 2'b10) begin
            res = res_reg + isqrt_y; 
            res_vld = '1; 
        end
        else 
            res_vld = '0;

endmodule
