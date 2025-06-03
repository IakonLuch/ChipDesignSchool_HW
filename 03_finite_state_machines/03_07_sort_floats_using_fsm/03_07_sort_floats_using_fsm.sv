//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module sort_floats_using_fsm (
    input                          clk,
    input                          rst,

    input                          valid_in,
    input        [0:2][FLEN - 1:0] unsorted,

    output logic                   valid_out,
    output logic [0:2][FLEN - 1:0] sorted,
    output logic                   err,
    output                         busy,

    // f_less_or_equal interface
    output logic      [FLEN - 1:0] f_le_a,
    output logic      [FLEN - 1:0] f_le_b,
    input                          f_le_res,
    input                          f_le_err
);

    enum logic [2:0]
    {
        st_IDLE	    = 3'd0,
        st_first	= 3'd1,
        st_second	= 3'd2,
		st_third	= 3'd3
    }
	state, next_state;
	
	always_ff @ (posedge clk)
		if (rst) 

            begin
			state <= st_IDLE;
			valid_out <= '0;
			err <= '0;
		    end 
        
        else 
        begin
		case(state)

			st_IDLE: 

				begin
				valid_out <= '0;
				err <= '0;
				if (valid_in) begin
					sorted <= unsorted;
					f_le_a <= unsorted[0];
					f_le_b <= unsorted[1];
					state <= st_first;
				end
				end

			st_first: 

				begin
				if (f_le_err) 
                begin
					err <= '1;
					valid_out <= '1;
					state <= st_IDLE;
				end 
                
                else if  (f_le_res) 
                begin
					state <= st_second;
					f_le_a <= sorted[1];
					f_le_b <= sorted[2];
				end 
                
                else 
                begin
					sorted <=  {sorted[1], sorted[0], sorted[2]};
					state <= st_second;
					f_le_a <= sorted[0];
					f_le_b <= sorted[2];
				end
				end
			st_second: 

				begin
				if (f_le_err) 
                begin
					err <= '1;
					valid_out <= '1;
					state <= st_IDLE;
				end 
                else if  (f_le_res) 
                begin
					state <= st_third;
					f_le_a <= sorted[0];
					f_le_b <= sorted[1];
				end 
                else 
                begin

					sorted <=  {sorted[0], sorted[2], sorted[1]};
					state <= st_third;
					f_le_a <= sorted[0];
					f_le_b <= sorted[2];

				end
				end
			st_third: 

				begin
				if (f_le_err) 

                    begin
					err <= '1;
					valid_out <= '1;
					state <= st_IDLE;
					end 

                else if  (f_le_res) 
                    
                    begin
					valid_out <= '1;
					state <= st_IDLE;
				    end 
                        
                else 

                    begin
					sorted <=  {sorted[1], sorted[0], sorted[2]};
					valid_out <= '1;
					state <= st_IDLE;
					end

				end
			endcase
		end
	
endmodule
