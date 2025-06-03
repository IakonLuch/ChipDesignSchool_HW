//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module double_tokens
(
    input        clk,
    input        rst,
    input        a,
    output       b,
    output logic overflow
);
    
        logic [7:0] c = '0;
        assign b = a | (c>0);

        always_ff @(posedge clk) begin
            if (rst | overflow) begin
                c <= '0;
                overflow <= '0;
            end
            else if (a) begin
                c <= c + 1;
                if (c >= 198)
                    overflow <= 1;
            end 
                 else if (a == 0)
                    if (c != 0)
                        c <= c - 1;
        end


endmodule
