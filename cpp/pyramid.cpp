#include <iostream>
#include <string.h>
// g++ -o main main.cpp

using namespace std;

void createPyramid(int row);

int main() {
  cout << "Pyramid Pattern: \n";
  cout << "A simple C++ program \n";
  cout << "Created by: James Little 23/11/22 \n";
  cout << "\n";
  cout << "How many rows would you like?\n";
  int rows;
  cin >> rows;
  createPyramid(rows);
  return 0;
}
void createPyramid(int rows) {
  for (size_t i = 0; i < rows; i++) {
    string pyramidRow = "";
    for (size_t j = 0; j < i + 1; j++) {
      pyramidRow = pyramidRow + "*";
    }
    cout << pyramidRow + "\n";
  }

  cout << "done\n";
}