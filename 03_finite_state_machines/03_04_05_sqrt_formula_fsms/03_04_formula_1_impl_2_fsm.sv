//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module formula_1_impl_2_fsm
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

    output logic        isqrt_1_x_vld,
    output logic [31:0] isqrt_1_x,

    input               isqrt_1_y_vld,
    input        [15:0] isqrt_1_y,

    output logic        isqrt_2_x_vld,
    output logic [31:0] isqrt_2_x,

    input               isqrt_2_y_vld,
    input        [15:0] isqrt_2_y
);

    enum logic [1:0] 
    {
        st_idle        = 2'd0,
        st_wait_ab_res = 2'd1,
        st_wait_c_res  = 2'd2
    }
    state, next_state;

    /*always_comb
    begin
        next_state = state;

        isqrt_1_x_vld = '0;
        isqrt_2_x_vld = '0;
        isqrt_1_x = 'x;
        isqrt_2_x = 'x;

        case (state)
        st_idle:
        begin 
            isqrt_1_x = a;
            isqrt_2_x = b;

            if (arg_vld)
            begin
                isqrt_1_x_vld = '1;
                isqrt_2_x_vld = '1;
                next_state    = st_wait_ab_res;
            end
        end

        st_wait_ab_res:
        begin
            isqrt_1_x = c;
            isqrt_2_x = '0;

            if (isqrt_1_y_vld & isqrt_2_y_vld)
            begin
            isqrt_1_x_vld = '1;
            isqrt_2_x_vld = '1;
            next_state = st_wait_c_res;
            end
        end

        st_wait_c_res:
        begin
            if (isqrt_1_y_vld & isqrt_2_y_vld)
            begin 
                next_state = st_idle;
            end
        end
        endcase

    end

    always_ff @(posedge clk)
        if (rst)
            state <= st_idle;
        else 
            state <= next_state;

    always_ff @ (posedge clk)
        if (rst)
            res_vld <= '0;
        else 
            res_vld <= (state == st_wait_c_res & isqrt_1_y_vld & isqrt_2_y_vld);


    always_ff @ (posedge clk)
        if (state == st_idle)
            res <= '0;
        else if (isqrt_1_y_vld & isqrt_2_y_vld & state != st_wait_c_res)
            res <= res +  (isqrt_1_y) +  (isqrt_2_y);
    */

    always_comb
    begin
        next_state = state;

        case (state)
        st_idle       : if ( arg_vld     ) next_state = st_wait_ab_res ;
        st_wait_ab_res : if ( isqrt_1_y_vld & isqrt_2_y_vld ) next_state = st_wait_c_res ;
        st_wait_c_res : if ( isqrt_1_y_vld & isqrt_2_y_vld ) next_state = st_idle       ;
        endcase
    end

    always_ff @ (posedge clk)
        if (rst)
            state <= st_idle;
        else
            state <= next_state;

    always_comb
    begin
        isqrt_1_x_vld = '0;
        isqrt_2_x_vld = '0;

        case (state)
        st_idle       : 
        begin 
            isqrt_1_x_vld = arg_vld;
            isqrt_2_x_vld = arg_vld;
        end

        st_wait_ab_res : 
        begin 
            isqrt_1_x_vld = isqrt_1_y_vld;
            isqrt_2_x_vld = isqrt_2_y_vld;
        end
        endcase
    end

    always_comb
    begin
        isqrt_1_x = 'x; 
        isqrt_2_x = 'x;

        case (state)
        st_idle       : begin isqrt_1_x = a; isqrt_2_x = b; end
        st_wait_ab_res : begin isqrt_1_x = c; isqrt_2_x = '0; end
        endcase
    end

    // The result

    always_ff @ (posedge clk)
        if (rst)
            res_vld <= '0;
        else
            res_vld <= (state == st_wait_c_res & isqrt_1_y_vld & isqrt_2_y_vld);

    always_ff @ (posedge clk)
        if (state == st_idle)
            res <= '0;
        else if (isqrt_1_y_vld & isqrt_2_y_vld)
            res <= res + isqrt_1_y + isqrt_2_y;

endmodule
