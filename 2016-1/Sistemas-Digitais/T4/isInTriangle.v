`include "sign.v"

/**
 *	Equivalente à seguinte função em C++:
 *
 *	 int isInTriangle(ponto p, triangulo t) {
 *		 bool b1 = sign(p, t.a, t.b) < 0;
 *		 bool b2 = sign(p, t.b, t.c) < 0;
 *		 bool b3 = sign(p, t.c, t.a) < 0;
 *
 *		 return ( (b1 == b2) && (b2 == b3) );
 *	 }
 *
 */

module isInTriangle(
	input [11:0] px, input [11:0] py,
	input [11:0] ax, input [11:0] ay,
	input [11:0] bx, input [11:0] by,
	input [11:0] cx, input [11:0] cy,
	output out
);
	wire b1;
	wire b2;
	wire b3;

	sign S1(px, py, ax, ay, bx, by, b1);
	sign S2(px, py, bx, by, cx, cy, b2);
	sign S3(px, py, cx, cy, ax, ay, b3);

	assign out = (b1 == b2) & (b2 == b3);
endmodule
