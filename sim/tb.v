`timescale 1us/1ns

module tb;
    
top dut (
    
);

initial clk_10KHz = 0;
always #50 clk_10KHz = ~clk_10KHz;

initial begin
    
    $finish;
end
endmodule