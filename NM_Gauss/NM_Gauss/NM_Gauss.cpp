// NM_Gauss.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include "pch.h"
#include <iostream>

using namespace std;

int main()
{
    //input
	int n;
	float a[5][5], b[5], x[5], temp[5][5];

	cout << "Enter quantity N=" << endl;
	cin >> n;

	for (int i = 0; i < n; i++)
		for (int j = 0; j < n; j++)
		{
			cout << "Current element = " << endl;
			cin >> a[i][j];
		}

	cout << "Enter free members column" << endl;

	for (int i = 0; i < n; i++)
	{
		cout << "Current free member = " << endl;
		cin >> b[i];
	}

// COMPUTING
/*	float temp;

	for (int k = 0; k < (n - 1); k++)
	
		for (int i = (k + 1); i < n; i++)
		{
			temp = a[i][k] / a[k][k];
			b[i] = b[i] - temp * b[k];

			for (int j = k + 1; j < n; j++)
				a[i][j] = a[i][j] - temp * a[k][j];
		}
*/	

	for (int k = 0; k < (n - 1); k++)
		for (int i = (k+1); i < n; i++)
			{
				temp[i][k] = a[i][k] / a[k][k];
				b[i] = b[i] - temp[i][k] * b[k];
			for (int j = k; j < n; j++)
				a[i][j] = a[i][j] - temp[i][k] * a[k][j];
			}

	x[n - 1] = b[n - 1] / a[n - 1][n - 1];

	for (int k = n - 2; k >= 0; k--)
	{
		float summ = 0;
		for (int j = k + 1; j < n; j++)
			summ += a[k][j] * x[j];

		x[k] = (b[k] - summ) / a[k][k];
	}

///// output
	cout << endl;

	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			cout << a[i][j]<< "  ";
		}
		cout << "| " << b[i];

		cout << endl;
	}

// zero det chkng 
	float det = 1;

	for (int i = 0; i < n; i++)
		det *= a[i][i];

	if (det == 0)
		cout << "det = 0" << endl;
	else
	{
		// vector x
		cout << endl << "   vector x :   ";
		for (int i = 0; i < n; i++)
		{
			cout << x[i] << "  ";
		}
		cout << endl;
	}
	//system("pause");
}

