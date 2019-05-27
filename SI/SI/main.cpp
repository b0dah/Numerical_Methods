// NM_simple_iterations_method.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <fstream>
#include <string>
#include <math.h>
#include <vector>

using namespace std;

void WritingFromFileToMatrix(string path, double (*a)[3])
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
        for (int i=0;i<2;i++)
            for (int j=0;j<3;j++)
            {
                file_in >> current_value;
                // cout << current_value << endl;
                a[i][j] = current_value;
            }
    }
    file_in.close();
}

double MatrixDeterminant(double (*a)[3])
{

    return a[0][0]*a[1][1] - a[1][0]*a[0][1];
}

bool ConvergenceConditionChecking(double *a[3])
{
    double line_summ = 0;
    
    for (int i = 0; i < 2; i++)
    {
        for (int j = 0; j < 2; j++)
        {
            if (i != j) line_summ += fabs(a[i][j]);
        }
        if (fabs(line_summ)>fabs(a[i][i])) return 0;
    }
    return 1;
}

void ToNormalShape(double (*a)[3])        // diagonal editing
{
    for (int i = 0; i < 2; i++)
        for (int j = 0; j < 3; j++)
        {
            if (i!=j)
                if ( j<2 )
                    a[i][j] /= -a[i][i];
                else
                    a[i][j] /= a[i][i]; //!!
        }
}

double NormOfTheMatrix(double (*a)[3])
{
    double max=0, summ_of_the_line = 0;
    
    for (int i = 0; i < 2; i++)
    {
        summ_of_the_line = 0;
        for (int j = 0; j < 2; j++)
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
    
    for (int i = 1; i < 2; i++)
    {
        if ( fabs(a[i] - x[i]) > max )
            max = fabs(a[i] - x[i]);
    }
    return max;
}

void CopyArrayToAnotherOne(double *x_destination, double *x_original)
{
    for (int i=0;i<2;i++)
        x_destination[i] = x_original[i];
}

void OutputMatrix(double (*matrix)[3])
{
    cout.width(2);
    
    for (int i = 0; i < 2; i++)
    {
        cout << "\n x[" << i + 1 << "] = ";
        for (int j = 0; j < 2; j++)
        {
            if (i != j)
            {
                if (matrix[i][j] < 0)
                    cout << "(" << matrix[i][j] << ")*" << "x[" << j + 1 << "]";
                else cout << matrix[i][j] << "*" << "x[" << j + 1 << "]";
                cout << " + ";
            }
        }
        if (matrix[i][2] < 0)
            cout << "(" << matrix[i][2] << ")";
        else cout << matrix[i][2];
        
    }
}

void outputVector(double *v){
    /*for (auto &iter: v) {
        cout << iter<< "  ";
    }*/
    for (int i=0; i<2; i++) {
        cout << v[i] << "  ";
    }
    cout << endl;
}

int main()
{
    const double eps = 1e-5;
    
    double matrix[2][3];
    //double free_members[3];
    
    
    
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
        
        double x_previous[2] = { 0,0}; // 0 - column here
        double x_current[2] = { matrix[0][2], matrix[1][2] }; // C - column here
        
        int numberofiterations = 0;
        
        while (MaximumDifference(x_current, x_previous) > eps)
        {
            double prev_difference = MaximumDifference(x_current, x_previous);
            
            CopyArrayToAnotherOne(x_previous, x_current);
            
            for (int i = 0; i < 2; i++)
            {
                x_current[i] = 0;
                for (int j = 0; j < 2; j++)
                    if (i != j)
                    {
                        x_current[i] += matrix[i][j] * x_previous[j];
                    }
                
                x_current[i] -= matrix[i][2];
                
            }
            numberofiterations++;
            
            
            if (MaximumDifference(x_current, x_previous) > prev_difference)
            {
                cout << "\n \n (!!) The cycle broke ahead of time because of increasing difference " << endl;
                break;
            }
        }
        
        // output
        
    //Solution:
        cout << "\n \n  SOLUTION: \n";
        for (int i = 0; i < 2; i++)
        {
            cout << "x[" << i + 1 << "] = " << x_current[i] << "   ";
        }
        cout << "\n" << numberofiterations << " iterations are done \n";
        
    }
    
    double vect1[2] = {1,1}, vect2[2]= {1.5,1};
    CopyArrayToAnotherOne(vect1, vect2);
    outputVector(vect1);
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

