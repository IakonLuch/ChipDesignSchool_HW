module put_in_order
# (
    parameter width    = 16,
              n_inputs = 4
)
(
    input                       clk,
    input                       rst,

    input  [ n_inputs - 1 : 0 ] up_vlds,
    input  [ n_inputs - 1 : 0 ]
           [ width    - 1 : 0 ] up_data,

    output                      down_vld,
    output [ width   - 1 : 0 ]  down_data
);

    logic [n_inputs - 1:0] [width - 1:0] up_data_reg;
    logic [n_inputs - 1:0] up_vlds_reg;

    always_ff @ (posedge clk)
        if (rst)
            up_vlds_reg <= '0; 
        else begin
            for (int i = 0; i < n_inputs; i ++)
                if ( (out_order_next == (i + 1)) & (! up_vlds [i]) )
                    up_vlds_reg [i] <= '0;
                else if (up_vlds [i])
                    up_vlds_reg [i] <= 1'b1;
        end

    always_ff @ (posedge clk) begin
        for (int i = 0; i < n_inputs; i++)
            if (up_vlds [i])
                up_data_reg [i] <= up_data [i];
    end
    
    logic [$clog2 (n_inputs - 1):0] out_order, out_order_next;

    always_ff @ (posedge clk)
        if (rst)
            out_order <= '0;
        else if (out_order_next == n_inputs)
            out_order <= '0;
        else
            out_order <= out_order_next; 
     
    logic [width - 1:0] out_data;
    logic out_vld; 

    always_comb begin 
        out_order_next = out_order;
        for (int i = 0; i < n_inputs; i++) begin
            if ((out_order == i) & up_vlds_reg [i]) 
                out_order_next = out_order + 1'b1;
        end
    end

    assign down_data = up_data_reg [out_order];
    assign down_vld = up_vlds_reg [out_order];

endmodule
