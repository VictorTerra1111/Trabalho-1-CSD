`timescale 1us/1ns

module tb;
      logic clk_100MHz_i;
      logic reset_i;      
      logic increment_i;    
      logic decrement_i;    
      logic config_i;

top dut (
    
);

initial clk_10KHz = 0;
always #50 clk_10KHz = ~clk_10KHz;

initial begin
    
    $finish;
end
endmodule