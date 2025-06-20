//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module sort_two_floats_ab (
    input        [FLEN - 1:0] a,
    input        [FLEN - 1:0] b,

    output logic [FLEN - 1:0] res0,
    output logic [FLEN - 1:0] res1,
    output                    err
);

    logic a_less_or_equal_b;

    f_less_or_equal i_floe (
        .a   ( a                 ),
        .b   ( b                 ),
        .res ( a_less_or_equal_b ),
        .err ( err               )
    );

    always_comb begin : a_b_compare
        if ( a_less_or_equal_b ) begin
            res0 = a;
            res1 = b;
        end
        else
        begin
            res0 = b;
            res1 = a;
        end
    end

endmodule

//----------------------------------------------------------------------------
//----------------------------------------------------------------------------

module sort_two_floats_array
(
    input        [0:1][FLEN - 1:0] unsorted,
    output logic [0:1][FLEN - 1:0] sorted,
    output                         err
);

    logic u0_less_or_equal_u1;

    f_less_or_equal i_floe
    (
        .a   ( unsorted [0]        ),
        .b   ( unsorted [1]        ),
        .res ( u0_less_or_equal_u1 ),
        .err ( err                 )
    );

    always_comb
        if (u0_less_or_equal_u1)
            sorted = unsorted;
        else
              {   sorted [0],   sorted [1] }
            = { unsorted [1], unsorted [0] };

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module sort_three_floats (
    input        [0:2][FLEN - 1:0] unsorted,
    output logic [0:2][FLEN - 1:0] sorted,
    output                         err
);

    logic u0_less_or_equal_u1, u1_less_or_equal_u2, u0_less_or_equal_u2, err1, err2, err3;

    assign err = err1 | err2 | err3;

    f_less_or_equal i_floe_1
    (
        .a   ( unsorted [0]        ),
        .b   ( unsorted [1]        ),
        .res ( u0_less_or_equal_u1 ),
        .err ( err1                 )
    );

    f_less_or_equal i_floe_2
    (
        .a   ( unsorted [1]        ),
        .b   ( unsorted [2]        ),
        .res ( u1_less_or_equal_u2 ),
        .err ( err2                 )
    );

    f_less_or_equal i_floe_3
    (
        .a   ( unsorted [0]        ),
        .b   ( unsorted [2]        ),
        .res ( u0_less_or_equal_u2 ),
        .err ( err3                 )
    );

    always_comb 

    case ({u0_less_or_equal_u1, u0_less_or_equal_u2, u1_less_or_equal_u2 })
        3'b000: {  sorted [2],  sorted [1], sorted [0] } = { unsorted [0], unsorted [1], unsorted [2] };
        3'b001: {  sorted [2],  sorted [1], sorted [0] } = { unsorted [0], unsorted [2], unsorted [1] };
        3'b011: {  sorted [2],  sorted [1], sorted [0] } = { unsorted [2], unsorted [0], unsorted [1] };
        3'b100: {  sorted [2],  sorted [1], sorted [0] } = { unsorted [1], unsorted [0], unsorted [2] };
        3'b110: {  sorted [2],  sorted [1], sorted [0] } = { unsorted [1], unsorted [2], unsorted [0] };
        3'b111: sorted = unsorted;
    endcase


        
endmodule
