# gtkwave::loadFile "dump.vcd"

set all_signals [list]

lappend all_signals tb.formula_1_impl_1_tb.if_1_1.i_formula_1_impl_1_top.clk
lappend all_signals tb.formula_1_impl_1_tb.if_1_1.i_formula_1_impl_1_top.rst
lappend all_signals tb.formula_1_impl_1_tb.if_1_1.i_formula_1_impl_1_top.arg_vld
lappend all_signals tb.formula_1_impl_1_tb.if_1_1.i_formula_1_impl_1_top.a
lappend all_signals tb.formula_1_impl_1_tb.if_1_1.i_formula_1_impl_1_top.b
lappend all_signals tb.formula_1_impl_1_tb.if_1_1.i_formula_1_impl_1_top.c
lappend all_signals tb.formula_1_impl_1_tb.if_1_1.i_formula_1_impl_1_top.isqrt_x_vld
lappend all_signals tb.formula_1_impl_1_tb.if_1_1.i_formula_1_impl_1_top.isqrt_x
lappend all_signals tb.formula_1_impl_1_tb.if_1_1.i_formula_1_impl_1_top.isqrt_y_vld
lappend all_signals tb.formula_1_impl_1_tb.if_1_1.i_formula_1_impl_1_top.isqrt_y
lappend all_signals tb.formula_1_impl_1_tb.if_1_1.i_formula_1_impl_1_top.res_vld
lappend all_signals tb.formula_1_impl_1_tb.if_1_1.i_formula_1_impl_1_top.res

lappend all_signals tb.formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.clk
lappend all_signals tb.formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.rst
lappend all_signals tb.formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.arg_vld
lappend all_signals tb.formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.a
lappend all_signals tb.formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.b
lappend all_signals tb.formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.c
lappend all_signals tb.formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.isqrt_1_x_vld
lappend all_signals tb.formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.isqrt_1_x
lappend all_signals tb.formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.isqrt_1_y_vld
lappend all_signals tb.formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.isqrt_1_y
lappend all_signals tb.formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.isqrt_2_x_vld
lappend all_signals tb.formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.isqrt_2_x
lappend all_signals tb.formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.isqrt_2_y_vld
lappend all_signals tb.formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.isqrt_2_y
lappend all_signals tb.formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.res_vld
lappend all_signals tb.formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.res

lappend all_signals tb.formula_2_tb.if_else.i_formula_2_top.clk
lappend all_signals tb.formula_2_tb.if_else.i_formula_2_top.rst
lappend all_signals tb.formula_2_tb.if_else.i_formula_2_top.arg_vld
lappend all_signals tb.formula_2_tb.if_else.i_formula_2_top.a
lappend all_signals tb.formula_2_tb.if_else.i_formula_2_top.b
lappend all_signals tb.formula_2_tb.if_else.i_formula_2_top.c
lappend all_signals tb.formula_2_tb.if_else.i_formula_2_top.isqrt_x_vld
lappend all_signals tb.formula_2_tb.if_else.i_formula_2_top.isqrt_x
lappend all_signals tb.formula_2_tb.if_else.i_formula_2_top.isqrt_y_vld
lappend all_signals tb.formula_2_tb.if_else.i_formula_2_top.isqrt_y
lappend all_signals tb.formula_2_tb.if_else.i_formula_2_top.res_vld
lappend all_signals tb.formula_2_tb.if_else.i_formula_2_top.res

# The following appends are necessary for compatibility
# with the older version of GTKWave

lappend all_signals formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.clk
lappend all_signals formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.rst
lappend all_signals formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.arg_vld
lappend all_signals formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.a
lappend all_signals formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.b
lappend all_signals formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.c
lappend all_signals formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.isqrt_1_x_vld
lappend all_signals formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.isqrt_1_x
lappend all_signals formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.isqrt_1_y_vld
lappend all_signals formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.isqrt_1_y
lappend all_signals formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.isqrt_2_x_vld
lappend all_signals formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.isqrt_2_x
lappend all_signals formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.isqrt_2_y_vld
lappend all_signals formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.isqrt_2_y
lappend all_signals formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.res_vld
lappend all_signals formula_1_impl_2_tb.if_1_2.i_formula_1_impl_2_top.res

lappend all_signals formula_2_tb.if_else.i_formula_2_top.clk
lappend all_signals formula_2_tb.if_else.i_formula_2_top.rst
lappend all_signals formula_2_tb.if_else.i_formula_2_top.arg_vld
lappend all_signals formula_2_tb.if_else.i_formula_2_top.a
lappend all_signals formula_2_tb.if_else.i_formula_2_top.b
lappend all_signals formula_2_tb.if_else.i_formula_2_top.c
lappend all_signals formula_2_tb.if_else.i_formula_2_top.isqrt_x_vld
lappend all_signals formula_2_tb.if_else.i_formula_2_top.isqrt_x
lappend all_signals formula_2_tb.if_else.i_formula_2_top.isqrt_y_vld
lappend all_signals formula_2_tb.if_else.i_formula_2_top.isqrt_y
lappend all_signals formula_2_tb.if_else.i_formula_2_top.res_vld
lappend all_signals formula_2_tb.if_else.i_formula_2_top.res

set num_added [ gtkwave::addSignalsFromList $all_signals ]

gtkwave::/Time/Zoom/Zoom_Full
