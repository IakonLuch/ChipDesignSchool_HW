//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module halve_tokens
(
    input  clk,
    input  rst,
    input  a,
    output b
);
   
    logic c = 0;
    assign b = a & c;
    

    always_ff @(posedge clk)
        if (rst) 
            c <= 0;
        else 
            c <= c^a;
        

endmodule
