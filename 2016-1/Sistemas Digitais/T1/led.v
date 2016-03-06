module test_led;
	wire led;
	reg clk;

	assign led = ~clk;

	always #1 clk = ~clk;

	initial begin
		$dumpvars(0,led);
		clk <= 0;
		#500;
		$finish;
	end
endmodule