module top(
    input logic clk_100MHz_i,
    input logic reset_i,

);

  dspl_drv_NexysA7 display(
        .clock(clock),
        .reset(reset),
        .d1(d1), .d2(d2), .d3(d3), .d4(d4),
        .d5(d5), .d6(d6), .d7(d7), .d8(d8),
        .an(an),
        .dec_ddp(dec_ddp)
    );
/*

 .d1(d1), .d2(d2), .d3(d3), .d4(d4),
        .d5(d5), .d6(d6), .d7(d7), .d8(d8),

    */

endmodule