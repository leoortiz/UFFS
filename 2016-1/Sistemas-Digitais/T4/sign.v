/**
 *	Equivalente à seguinte função em C++:
 *
 *	 int sign(ponto a, ponto b, ponto c) {
 *	 	return (a.x - c.x) * (b.y - c.y) - (b.x - c.x) * (a.y - c.y);
 *	 }
 *
 */

module sign(
	input [11:0] ax, input [11:0] ay,
	input [11:0] bx, input [11:0] by,
	input [11:0] cx, input [11:0] cy,
	output out
);
	reg [4:0] state;

	wire signed [11:0] t1;
	wire signed [11:0] t2;
	wire signed [11:0] t3;
	wire signed [11:0] t4;

	wire signed [23:0] m1;
	wire signed [23:0] m2;

	//
	//                          out
  //            m1             <            m2
  //      t1     *     t2      <      t3     *     t4
	// (a.x - c.x) * (b.y - c.y) < (b.x - c.x) * (a.y - c.y)
	//
	assign t1 = ax - cx;
	assign t2 = by - cy;
	assign t3 = bx - cx;
	assign t4 = ay - cy;

	assign m1 = t1 * t2;
	assign m2 = t3 * t4;

	assign out = m1 < m2;
endmodule
