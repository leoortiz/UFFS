#include <iostream>
#include <fstream>
#include <algorithm> // count()

using namespace std;

bool checkLines (ifstream& file_1, ifstream& file_2);
bool checkValues(ifstream& file_1, ifstream& file_2);

int main() {
	ifstream output_cpp("C++/output.txt");
	ifstream output_verilog("verilog/output.txt");

	if( checkLines(output_cpp, output_verilog) )
		checkValues(output_cpp, output_verilog);

	return 0;
}

bool checkLines(ifstream& file_1, ifstream& file_2) {
	int lines_file_1 = count(istreambuf_iterator<char>(file_1), istreambuf_iterator<char>(), '\n');
	int lines_file_2 = count(istreambuf_iterator<char>(file_2), istreambuf_iterator<char>(), '\n');

	cout << "Checking number of lines in Verilog output and C++ output..." << endl;

	file_1.clear();
	file_1.seekg(0, ios::beg);
	file_2.clear();
	file_2.seekg(0, ios::beg);

	if( lines_file_1 == lines_file_2 ) {
		cout << "OK" << endl;
		return true;
	} else {
		cout << "Error" << endl;
		return false;
	}
}

bool checkValues(ifstream& file_1, ifstream& file_2) {
	string sline_file_1;
	string sline_file_2;

	int line_file_1 = 1;
	int line_file_2 = 1;

	cout << "Checking if Verilog output and C++ output are identical line by line..." << endl;

	while( getline(file_1, sline_file_1) && getline(file_2, sline_file_2) ) {
		if(sline_file_1 != sline_file_2) {
			cout << "Error" << endl;
			cout << "C++ output line " << line_file_1 << " content: " << endl << sline_file_1 << endl;
			cout << "Verilog output line " << line_file_2 << " content: " << endl << sline_file_2 << endl;

			return false;
		}

		line_file_1++;
		line_file_2++;
	}

	cout << "OK" << endl;
	return true;
}
