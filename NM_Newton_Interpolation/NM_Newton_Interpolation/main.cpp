//
//  main.cpp
//  NM_Newton_Interpolation
//
//  Created by Иван on 26/10/2018.
//  Copyright © 2018 Иван. All rights reserved.
//

#include <iostream>
#include <vector>
#include <fstream>
#include <string>

#define input_file_path "input.txt"
using namespace std;

int n;
vector <double> x,y;
vector <vector <double>> divided_differences; //разделенные разности

struct point{
    double x_point, y_point;
};

vector <point> points;

void WritingFromFileToVector(string file_path, vector <double> *x, vector <double> *y, int *n)
{
    ifstream input_file;
    input_file.open(file_path);
    
    if (!input_file.is_open())
    {
        cout << "ERROR!! The file isn't open" << endl;
    }
    else
    {
        input_file >> *n; // узлов
        (*x).resize(*n);
        (*y).resize(*n);
        
        for (int i=0;i<*n;i++)          // writing x-es
            input_file >> (*x)[i];
        
        for (int i=0;i<*n;i++)          // writing y-es
            input_file >> (*y)[i];
    }
    input_file.close();
}

void WritingResultToFile(vector <double> a)
{
    ofstream output_file;
    output_file.open("output.txt");
    
    if (!output_file.is_open())
        cout << "\n ERROR!! The output file isn't open \n";
    else
    {
        for (int i=0;i<a.size();i++)
            output_file << to_string(a[i])<<"  ";
    }
    output_file.close();
}

void OutputVector(vector <double> a)
{
    cout << endl;
    for (int i = 0; i < a.size(); i++)
        cout <<a[i] <<"  ";
    cout << endl;
}

void FillingDividedDifferencesArray(int n)  // заполнение массива разд разностей
{
    divided_differences.resize(n-1);
    
    int cur_size = n-1;
    
    for (int k=0;k<n-1;k++) // ресайз
    {
        divided_differences[k].resize(cur_size);
        cur_size --;
    }
     
    for (int i=0;i<n-1;i++) // по х и у ///// заполнение нулевого столбца div_diffs[][]
    {
        int j = i;
        divided_differences[j][0] = (y[i]-y[i+1])/(x[i]-x[i+1]);
    }
    
   cur_size = n-2; // тк со вторгго столбца, то идем с высоты  - 3
    for (int j=1;j<n-1;j++) // заполнение остальных столбцов
    {
        for (int i=0;i<cur_size;i++)
        {
            
           /*+*/ divided_differences[i][j] = ( divided_differences[i][j-1] - divided_differences[i+1][j-1] ) / ( x[i] - x[i+(j+1)] );
            
        }
        cur_size--;
    }

}

double NewtonPolinomialValue(double arg)
{
    double summ = y[n-1], compos = (arg - x[n-1]);
    int j=0;
    
    for (int i=n-2; i > 0; i--)     // c (n-2) потому что x[n-1] уже записали
    {
        summ += compos * (divided_differences[i][j]);
        
        compos *= (arg - x[i]);
        j++;
    }
    
    
    return summ;
}

void MatrixOutput(vector <vector <double>> a)
{
    for (int i=0;i<a.size();i++)
    {
        for (int j=0; j<a[i].size();j++)
        {
            cout << a[i][j]<<"   ";
        }
        cout <<endl;
    }
}

void FillingValuesArray(int amount_of_points, vector <point> *a, double x_first, double x_last)
{
    (*a).resize(amount_of_points);
    double step = (x_last - x_first)/amount_of_points;
    
    double x_cur = x_first;
    
    for (int i=0; i<amount_of_points; i++)
    {
        (*a)[i].x_point = x_cur;
        (*a)[i].y_point = NewtonPolinomialValue(x_cur);
        
        x_cur += step;
    }
        
}

void WritinResultValuesToFile(string file_path, int amount_of_points, double x_first, double x_last)
{
    ofstream output_file;
    output_file.open(file_path);
    
    output_file << "     x       y \n";
    
    if (!output_file.is_open())
        cout << "\n ERROR!! The output file isn't open \n";
    else
    {
        double step = (x_last - x_first)/amount_of_points;

        double x_cur = x_first;

        for (int i=0; i<amount_of_points; i++)
        {
            output_file << to_string(x_cur) << "  ";
            output_file << to_string(NewtonPolinomialValue(x_cur))<<"\n";
            
            x_cur += step;
        }
    }
    output_file.close();
}

//======================================================================
int main(int argc, const char * argv[]) {
    
    WritingFromFileToVector(input_file_path, &x, &y, &n);
    
    FillingDividedDifferencesArray(n);
    
    /*FillingValuesArray(200, &points, -1, 1);
    
    for (int i=0;i<points.size();i++)
        cout << points[i].x_point << "  ";
    
    cout <<endl;
    
    for (int i=0;i<points.size();i++)
        cout << points[i].y_point << "  ";
    
    cout << endl;
    */
    
   WritinResultValuesToFile("output.txt", 1000, -1, 1);
    
    return 0;
}
