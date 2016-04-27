`include "isInTriangle.v"

module test;
	integer input_file;
	integer output_file;

	reg [90:0] value;

	reg [11:0] ax; reg [11:0] ay;
	reg [11:0] bx; reg [11:0] by;
	reg [11:0] cx; reg [11:0] cy;
	reg [11:0] px; reg [11:0] py;

	isInTriangle A( px,py, ax,ay, bx,by, cx,cy, saida );

	integer x; integer y;

	initial begin
		input_file  = $fopen("../C++/input.txt", "r");
		output_file = $fopen("output.txt", "w");

		if(input_file == 0) begin
			$display("Cannot open input_file located in '../C++/input.txt'. Does it exists?");
			$finish;
		end
	end

	always #2 begin
		if(!$feof( input_file ) ) begin
			value = $fscanf(input_file,  "A(%d,%d), B(%d,%d), C(%d,%d), P(%d,%d)\n", ax,ay, bx,by, cx,cy, px,py);
			#1
			$fwrite(output_file, "A(%0d,%0d), B(%0d,%0d), C(%0d,%0d), P(%0d,%0d) \t= %0d\n", ax,ay, bx,by, cx,cy, px,py, saida);
		end
		else
			$finish;
	end
endmodule
