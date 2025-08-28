module clock_divisor (
    input logic clock1M,
    input logic reset,
    output logic clk_10KHz,
    output logic clk_100KHz
);

  reg [7:0] clk10_cont;
  reg [7:0] clk100_cont;

  // clk_100KHz
  always @(posedge clock1M or posedge reset) begin
    if (reset) begin
      clk_100KHz <= 0;
      clk100_cont <= 0;
    end else begin
      if (clk100_cont == 4) begin
        clk_100KHz <= ~clk_100KHz;
        clk100_cont <= 0;
      end else begin
        clk100_cont <= clk100_cont + 1;
      end
    end
  end

  // clk_10KHz
  always @(posedge clock1M or posedge reset) begin
    if (reset) begin
      clk_10KHz <= 0;
      clk10_cont <= 0;
    end else begin
      if (clk10_cont == 49) begin
        clk_10KHz <= ~clk_10KHz;
        clk10_cont <= 0;
      end else begin
        clk10_cont <= clk10_cont + 1;
      end
    end
  end

endmodule