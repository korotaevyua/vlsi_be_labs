`timescale 1 ns / 100 ps

module testbench();

reg clk = 1'b0;

always begin
	#1 clk = ~clk;
end

wire out;

dff #(.clk(clk), out(out));

initial begin
	$dumpvars;

	#30 $finish;
end

endmodule
