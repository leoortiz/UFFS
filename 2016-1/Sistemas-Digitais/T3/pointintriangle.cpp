#include <iostream>
#include <fstream>  // files
#include <cstdlib>  // rand
#include <ctime>    // time
#include <cmath>    // abs()

#define size 500

using namespace std;

typedef struct ponto{
	int x, y;
} ponto;

typedef struct triangulo{
	ponto a;
	ponto b;
	ponto c;
} triangulo;

int sign(ponto a, ponto b, ponto c);
int isInTriangle(ponto p, triangulo t);

void writeOutput(triangulo tri, ponto p);

fstream output;

int main() {
	int i;
	ponto p[size];
	triangulo tri[size];
	
	srand( time(NULL) );
	
	output.open ( "output.txt" , ios::out );
	
	for(i = 0; i < size; i++) {
		tri[i].a.x = rand() % size + 1;
		tri[i].a.y = rand() % size + 1;
		
		tri[i].b.x = rand() % size + 1;
		tri[i].b.y = rand() % size + 1;
		
		tri[i].c.x = rand() % size + 1;
		tri[i].c.y = rand() % size + 1;
		
		p[i].x = rand() % size + 1;
		p[i].y = rand() % size + 1;
		
		writeOutput(tri[i], p[i]);
	}

	return 0;
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
	
	if( isInTriangle(p, tri) )
		output << "Ponto dentro do triangulo" << endl;
	else
		output << "Ponto fora do triangulo" << endl;
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
