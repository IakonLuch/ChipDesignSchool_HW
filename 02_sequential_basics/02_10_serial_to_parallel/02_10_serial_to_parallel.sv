//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module serial_to_parallel
# (
    parameter width = 8
)
(
    input                      clk,
    input                      rst,

    input                      serial_valid,
    input                      serial_data,

    output logic               parallel_valid,
    output logic [width - 1:0] parallel_data
);
            
    logic [2:0] count = '0;
    logic [width - 1:0] mem = '0;

    always_comb begin
        if (serial_valid)
            mem[count] = serial_data;
        if (serial_valid & count == (width-1)) begin
            parallel_valid = 1;
            parallel_data = mem;
        end
    end
    
    always_ff @(posedge clk) begin
        if (rst) begin
            count <= '0;
            mem <= '0;
        end
        else begin
            if (serial_valid & count == (width-1)) begin
                parallel_valid <= 0;
                parallel_data <= '0;
                count <= '0;
                mem <= '0;
            end
            else 
                if (serial_valid) begin
                count <= count + 1;
            end
        end
    end
endmodule
