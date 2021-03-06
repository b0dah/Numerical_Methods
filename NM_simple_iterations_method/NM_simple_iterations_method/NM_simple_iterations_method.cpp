// NM_simple_iterations_method.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include "pch.h"
#include <iostream>
#include <fstream>
#include <string>

using namespace std;

void WritingFromFileToMatrix(string path, double (*a)[4])
{
	ifstream file_in;
	file_in.open(path);

	if (!file_in.is_open())
	{
		cout << "Error!! THe file isn't open" << endl;
	}
	else
	{
		cout << "The file is open" << endl;
		double current_value;
		

		// while (!file_in.eof())
		for (int i=0;i<3;i++)
			for (int j=0;j<4;j++)
			{
				file_in >> current_value;
				// cout << current_value << endl;
				a[i][j] = current_value;
			}
	}
	file_in.close();
}

double MatrixDeterminant(double (*a)[4])
{
	int n = 3; 
	double temp[3][4], buffer[3][4];

	for (int i = 0; i < n; i++)//cpng
		for (int j = 0; j < n; j++)
			buffer[i][j] = a[i][j];
	
	for (int k = 0; k < (n - 1); k++)
		for (int i = (k + 1); i < n; i++)
		{
			temp[i][k] = buffer[i][k] / buffer[k][k];
			//b[i] = b[i] - temp[i][k] * b[k];
			for (int j = k; j < n; j++)
				buffer[i][j] = buffer[i][j] - temp[i][k] * buffer[k][j];
		}

	double det = 1;

	for (int i = 0; i < n; i++)
		det *= a[i][i];

	if (det == 0)
		return 0;
	else return det;
}

bool ConvergenceConditionChecking(double *a[3])
{
	double line_summ = 0;

	for (int i = 0; i < 3; i++)
	{
		for (int j = 0; j < 3; j++)
		{
			if (i != j) line_summ += fabs(a[i][j]);
		}
		if (fabs(line_summ)>fabs(a[i][i])) return 0;
	}
	return 1;
}

void ToNormalShape(double (*a)[4])		// diagonal editing
{
	for (int i = 0; i < 3; i++)
		for (int j = 0; j < 4; j++)
		{
			if (i!=j)
				if ( j<3 )
					a[i][j] /= -a[i][i];
				else 
					a[i][j] /= a[i][i]; //!!
		}
}

double NormOfTheMatrix(double (*a)[4])
{
	double max=0, summ_of_the_line = 0;

	for (int i = 0; i < 3; i++)
	{
		summ_of_the_line = 0;
		for (int j = 0; j < 3; j++)
			if (i!=j)
				summ_of_the_line += fabs(a[i][j]);  // диагональные элменты не считаем!!

		if (summ_of_the_line > max)
			max = summ_of_the_line;
	}

	return max;
}

double MaximumDifference(double *a, double *x)
{
	double max = fabs(a[0] - x[0]);

	for (int i = 1; i < 3; i++)
	{
		if ( fabs(a[i] - x[i]) > max )
			max = fabs(a[i] - x[i]);
	}
	return max;
}

void CopyArrayToAnotherOne(double *x_destination, double *x_original)
{
	for (int i=0;i<3;i++)
		x_destination[i] = x_original[i];
}

void OutputMatrix(double (*matrix)[4])
{
	cout.width(3);

	for (int i = 0; i < 3; i++)
	{
		cout << "\n x[" << i + 1 << "] = ";
		for (int j = 0; j < 3; j++)
		{
			if (i != j)
			{
				if (matrix[i][j] < 0)
					cout << "(" << matrix[i][j] << ")*" << "x[" << j + 1 << "]";
				else cout << matrix[i][j] << "*" << "x[" << j + 1 << "]";
				cout << " + ";
			}
		}
		if (matrix[i][3] < 0)
			cout << "(" << matrix[i][3] << ")";
		else cout << matrix[i][3];

	}
}

int main()
{
	const double eps = 0.001;

	double matrix[3][4];
	//double free_members[3];


/* input --
	cout << "Enter coefficients" << endl;

	for (int i = 0; i < 3; i++)
		for (int j=0; j<3; j++)
		{
		cout << " Current element = ";
		cin >> matrix[i][j];
		}

	cout << "Enter Free Members column:" << endl;
	for (int i = 0; i < 3; i++)
	{
		cout << "Current member = ";
		cin >> matrix[i][3];
		matrix[i][3] *= (-1);
	}
*/

	WritingFromFileToMatrix("input.txt", matrix);

	if (MatrixDeterminant(matrix) == 0) cout << "\n Determinant = 0" << endl;
	else
	{
		cout << "\n Determinant != 0" << endl;
		ToNormalShape(matrix);

		if (NormOfTheMatrix(matrix) <= 1)
			cout << " \n |||||| The convergence condition is satisfied |||||| \n";
		else cout << "  The convergence condition is NOT satisfied *!*!*!* ";

		cout << "\n Normalized matrix: " << endl;
		OutputMatrix(matrix);
		//-----------------------

		double x_previous[3] = { 0,0,0 }; // 0 - column here
		double x_current[3] = { matrix[0][3], matrix[1][3], matrix[2][3] }; // C - column here

		int numberofiterations = 0;

		while (MaximumDifference(x_current, x_previous) > eps)
		{
			double prev_difference = MaximumDifference(x_current, x_previous);

			CopyArrayToAnotherOne(x_previous, x_current);

			for (int i = 0; i < 3; i++)
			{
				x_current[i] = 0;
				for (int j = 0; j < 3; j++)
					if (i != j)
					{
						x_current[i] += matrix[i][j] * x_previous[j];
					}

				x_current[i] += matrix[i][3];

			}
			numberofiterations++;


			if (MaximumDifference(x_current, x_previous) > prev_difference)
			{
				cout << "\n \n (!!) The cycle broke ahead of time because of increasing difference " << endl;
				break;
			}
		}

		// output

	Solution:
		cout << "\n \n  SOLUTION: \n";
		for (int i = 0; i < 3; i++)
		{
			cout << "x[" << i + 1 << "] = " << x_current[i] << "   ";
		}
		cout << "\n" << numberofiterations << " iterations are done \n";

	}

}
// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
