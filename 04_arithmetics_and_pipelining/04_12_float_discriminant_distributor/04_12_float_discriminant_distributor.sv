module float_discriminant_distributor (
    input                           clk,
    input                           rst,

    input                           arg_vld,
    input        [FLEN - 1:0]       a,
    input        [FLEN - 1:0]       b,
    input        [FLEN - 1:0]       c,

    output logic                    res_vld,
    output logic [FLEN - 1:0]       res,
    output logic                    res_negative,
    output logic                    err,

    output logic                    busy
);

    parameter latency = 10; 

    logic [latency - 1:0] index;  

    logic [latency - 1:0] arg_vld_reg, err_dis, res_negative_dis;
    logic [FLEN - 1:0] a_reg [latency - 1:0];
    logic [FLEN - 1:0] b_reg [latency - 1:0]; 
    logic [FLEN - 1:0] c_reg [latency - 1:0];
    logic [FLEN - 1:0] discr_res [latency - 1:0]; 

    logic [latency - 1:0] discr_res_vld; 

    genvar i; 
    generate
            for (i = 0; i < latency; i ++) begin
                float_discriminant discriminant_ 
                (
                    .clk          ( clk                  ), 
                    .rst          ( rst                  ), 
                    .arg_vld      ( arg_vld_reg [i]      ), 
                    .a            ( a_reg [i]            ), 
                    .b            ( b_reg [i]            ), 
                    .c            ( c_reg [i]            ), 
                    .res_negative ( res_negative_dis [i] ),
                    .err          ( err_dis [i]          ),
                    .res_vld      ( discr_res_vld [i]    ), 
                    .res          ( discr_res [i]        )
                );
 
                assign index [i] = (i == count) ? 1'b1 : '0;

                always_ff @ (posedge clk)
                    if (rst) 
                        arg_vld_reg <= '0; 
                    else if (index [i])
                        arg_vld_reg [i] <= arg_vld;
                    else
                        arg_vld_reg [i] <= '0;

                always_ff @ (posedge clk)
                    if (arg_vld & index [i]) begin
                        a_reg [i] <= a; 
                        b_reg [i] <= b; 
                        c_reg [i] <= c;
                    end
            end 
    endgenerate

    logic [8:0] count; 
    
    always_ff @ (posedge clk)
        if (rst)
            count <= '0; 
        else if (count == (latency - 1))
            count <= '0; 
        else if (arg_vld)
            count <= count + 1'b1; 


    logic [FLEN - 1:0] res_mux;
    
    logic [latency - 1:0] err_mux;

    always_comb begin
        for (int i = 0; i < latency; i++) 
        begin
            if (discr_res_vld [i]) 
                begin
                    res_mux = discr_res [i];
                    err_mux = err_dis [i];
                end
        end    
    end

    assign res = res_mux;
    assign res_vld = | discr_res_vld;
    assign err = err_mux;


endmodule
