//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module round_robin_arbiter_with_2_requests #(parameter N = 2)
(
    input          clk,
    input          rst,
    input  [N-1:0] requests,
    output [N-1:0] grants
);

    logic [1:0] out;
    logic queue;

    always_comb begin
    case (requests)
            2'b00 : out = 2'b00;
            2'b01 : out = 2'b01;
            2'b10 : out = 2'b10;
            2'b11 : begin 
             if (queue) 
                  out = 2'b01;
             else 
                  out = 2'b10;  
                end
        endcase
    end 

    assign grants = out;

    always_ff @(posedge clk) 
        if (rst) begin
            queue <= 0;
        end
        else if (^requests) 
               queue <= requests[1];
                else queue <= 0;

endmodule
