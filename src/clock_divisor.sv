module clock_divisor(
    input logic clk_100MHz_i,
    input logic reset_i,
    output logic seconds_pulse_o
);

 // as we need to count to a hundred million for a second, the counter sould go from 27:0,
 // so it can store 134 217 728
  
  reg [27:0] counter; 

  always @(posedge clk_100MHz_i or posedge reset_i) begin
    if (reset_i) begin
      counter <= 0;
      seconds_pulse_o <= 0;
    end else begin
      if (counter == 100_000_000 - 1) begin
        counter <= 0;
        seconds_pulse_o <= 1;
      end else begin
        counter <= counter + 1;
        seconds_pulse_o <= 0;
      end
    end
  end

endmodule