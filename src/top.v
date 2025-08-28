module top(
    input  logic clk_100MHz_i,
    input  logic reset_i,      
    input  logic increment_i,    
    input  logic decrement_i,    
    input  logic config_i,   
    
    output logic [7:0] d1, d2, d3, d4, d5, d6, d7, d8, 
    output logic [7:0] an,                             
    output logic [3:0] dec_ddp                         
);

    logic second_tick, btn_inc_db, btn_dec_db, btn_mode_db;
    logic [5:0] seconds_o, minutes_o;
    logic [4:0] hours_o;

    clock_divisor div (
        .clk_100MHz_i(clk_100MHz_i),
        .reset(reset_i),
        .second(second_tick)       
    );

    counter c (
        .clk_100MHz_i(clk_100MHz_i),
        .reset_i(reset_i),
        .seconds_pulse_i(second_tick),
        .seconds_o(seconds_o),
        .minutes_o(minutes_o),
        .hours_o(hours_o)
    );

    debounce #(.DELAY(500_000)) deb_inc (
        .clk_i(clk_100MHz_i),
        .rstn_i(reset_i),
        .key_i(increment_i),
        .debkey_o(btn_inc_db)
    );

    debounce #(.DELAY(500_000)) deb_dec (
        .clk_i(clk_100MHz_i),
        .rstn_i(reset_i),
        .key_i(decrement_i),
        .debkey_o(btn_dec_db)
    );

    debounce #(.DELAY(500_000)) deb_config (
        .clk_i(clk_100MHz_i),
        .rstn_i(reset_i),
        .key_i(config_i),
        .debkey_o(btn_mode_db)
    );

    dspl_drv_NexysA7 display_inst(
        .clock(clk_100MHz_i),
        .reset(reset_i),
        .d1(d1), .d2(d2), .d3(d3), .d4(d4),
        .d5(d5), .d6(d6), .d7(d7), .d8(d8),
        .an(an),
        .dec_ddp(dec_ddp)
    );

    
endmodule
