module counter (
    input  logic clk_100MHz_i,
    input  logic reset_i,           
    input  logic seconds_pulse_i,   
    
    output logic [5:0] seconds_o,   // 0-59
    output logic [5:0] minutes_o,   // 0-59
    output logic [4:0] hours_o      // 0-23
);

    reg pulse;

    always @(posedge clk_100MHz_i or negedge reset_i) begin
        if (!reset_i) begin
            seconds_o <= 0;
            minutes_o <= 0;
            hours_o   <= 0;
            pulse   <= 0;
        end else begin
            pulse <= seconds_pulse_i;

            if (seconds_pulse_i && !pulse) begin
                if (seconds_o == 59) begin
                    seconds_o <= 0;
                    if (minutes_o == 59) begin
                        minutes_o <= 0;
                        if (hours_o == 23)
                            hours_o <= 0;
                        else
                            hours_o <= hours_o + 1;
                    end else begin
                        minutes_o <= minutes_o + 1;
                    end
                end else begin
                    seconds_o <= seconds_o + 1;
                end
            end
        end
    end
endmodule
