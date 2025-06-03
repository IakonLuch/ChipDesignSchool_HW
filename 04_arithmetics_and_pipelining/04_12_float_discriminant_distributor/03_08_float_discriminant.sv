//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module float_discriminant (
    input                     clk,
    input                     rst,

    input                     arg_vld,
    input        [FLEN - 1:0] a,
    input        [FLEN - 1:0] b,
    input        [FLEN - 1:0] c,

    output logic              res_vld,
    output logic [FLEN - 1:0] res,
    output logic              res_negative,
    output logic              err,

    output logic              busy
);

    localparam [FLEN - 1:0] four = 64'h4010_0000_0000_0000;
	
	logic [FLEN-1:0] b_square_res, ac_res, ac4_res;
    
	logic b_square_vld, ac_vld, ac4_vld;
	logic bs_b_square, bs_ac, bs_4ac, bs_sub;
    logic err_b_square, err_ac, err_4ac, err_sub;
	
	f_mult i_mult_b_square (
		.clk(clk),
		.rst(rst),
		.a(b), 
		.b(b),
		.up_valid(arg_vld),
		.res(b_square_res),
		.down_valid(b_square_vld),
		.busy(bs_b_square),
		.error(err_b_square)
	);
	
	f_mult i_mult_ac (
		.clk(clk),
		.rst(rst),
		.a(a), 
		.b(c),
		.up_valid(arg_vld),
		.res(ac_res),
		.down_valid(ac_vld),
		.busy(bs_ac),
		.error(err_ac)
	);
	
	f_mult i_mult_4ac (
		.clk(clk),
		.rst(rst),
		.a(four), 
		.b(ac_res),
		.up_valid(ac_vld & b_square_vld),
		.res(ac4_res),
		.down_valid(ac4_vld),
		.busy(bs_4ac),
		.error(err_4ac)
	);
	
	f_sub i_sub (
		.clk(clk),
		.rst(rst),
		.a(b_square_res), 
		.b(ac4_res),
		.up_valid(ac4_vld),
		.res(res),
		.down_valid(res_vld),
		.busy(bs_sub),
		.error(err_sub)
	);
	
	always_comb
    begin
        busy = bs_b_square | bs_ac | bs_4ac | bs_sub;
        err = err_b_square | err_ac | err_4ac | err_sub;
        res_negative = (res[FLEN-1] == 1'b1);
    end

endmodule
