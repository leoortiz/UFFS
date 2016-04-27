#include <iostream>
#include <fstream>
#include <cstdlib>  // rand
#include <ctime>

#define sizeX 640
#define sizeY 480

using namespace std;

typedef struct ponto{
	int x;
	int y;
} ponto;

typedef struct triangulo{
	ponto a;
	ponto b;
	ponto c;
} triangulo;

int sign(ponto a, ponto b, ponto c);
int isInTriangle(ponto p, triangulo t);

void writeInput (triangulo tri, ponto p);
void writeOutput(triangulo tri, ponto p);

fstream input;
fstream output;

int main() {
	int i;
	triangulo tri[sizeX];
	ponto p[sizeX];

	srand( time(NULL) );

	input.open  ( "input.txt"  , ios::out );
	output.open ( "output.txt" , ios::out );

	for( i = 0; i < sizeX; i++ ) {
		tri[i].a.x = rand() % sizeX + 1;
		tri[i].a.y = rand() % sizeY + 1;

		tri[i].b.x = rand() % sizeX + 1;
		tri[i].b.y = rand() % sizeY + 1;

		tri[i].c.x = rand() % sizeX + 1;
		tri[i].c.y = rand() % sizeY + 1;

		p[i].x = rand() % sizeX + 1;
		p[i].y = rand() % sizeY + 1;

		writeInput (tri[i], p[i]);
		writeOutput(tri[i], p[i]);
	}

	return 0;
}

void writeInput(triangulo tri, ponto p) {
	input << "A(";
	input << tri.a.x << ",";
	input << tri.a.y << "), ";

	input << "B(";
	input << tri.b.x << ",";
	input << tri.b.y << "), ";

	input << "C(";
	input << tri.c.x << ",";
	input << tri.c.y << "), ";

	input << "P(";
	input << p.x << ",";
	input << p.y << ")" << endl;
}

void writeOutput(triangulo tri, ponto p) {
	output << "A(";
	output << tri.a.x << ",";
	output << tri.a.y << "), ";

	output << "B(";
	output << tri.b.x << ",";
	output << tri.b.y << "), ";

	output << "C(";
	output << tri.c.x << ",";
	output << tri.c.y << "), ";

	output << "P(";
	output << p.x << ",";
	output << p.y << ") \t= ";

	output << isInTriangle(p, tri) << endl;
}

int sign(ponto a, ponto b, ponto c) {
	return (a.x - c.x) * (b.y - c.y) - (b.x - c.x) * (a.y - c.y);
}

int isInTriangle(ponto p, triangulo t) {
	bool b1 = sign(p, t.a, t.b) < 0;
	bool b2 = sign(p, t.b, t.c) < 0;
	bool b3 = sign(p, t.c, t.a) < 0;

	return ( (b1 == b2) && (b2 == b3) );
}
