//
//  main.cpp
//  NM_Aitken_process
//

#include <iostream>
#include <math.h>
#include <iomanip>

using namespace std;

int it =1;

const double pi = 3.1415;

double sourceFunction(double x) {
    /*+*///return cos(pi*x);
    //return log(x);
    /*+*///return 3*x - 1;
    /*+*///return x*x - 1;
    /*+*///return x*x*x - 1;21567
    /*+*///return sqrt(x)-1;
    /*+*/return sin(x);
}

double Derivative(double x0, double accuracy){
    double h = accuracy;
    
    return (sourceFunction(x0 + h) - sourceFunction(x0 - h))/(2*h);
}

double transformatedFunction(double x, double x0){  // works with tranformation: fi = x - lambda*f(x);
    //return log(x);
    //return cos(pi*x);
    /*+*///return x - log(x);
    //return x - cos(pi*x/10);
    /*+*///return x-x+2;
    /*+*///return x - sqrt(x)+1;
    double res = sourceFunction(x);
    //cout << endl << Derivative(x0, 0.01)<<endl;
    res *= -1/Derivative(0.1, 0.01);
    res +=x;
    return res;
}

double AitkenProcessResult(double x0, double q, double eps)
{
    double x1, x2, x_accelerated, x3;
    
    /* 1 */ x1 = transformatedFunction(x0, x0);
    x2 = transformatedFunction(x1, x0);
    
    while (true) {
        it++;
        /* 2 */ x_accelerated = ( x0*x2 - x1*x1 ) / (x2 - 2*x1 + x0);
        /* 3 */ x3 = transformatedFunction(x_accelerated, x0);
        
        /* 4 Checking */
        if (fabs(x3 - x_accelerated) > (1-q)*eps/q )    {
            x0 = x_accelerated;
            x1  = x3;
            x2 = transformatedFunction(x1, x0);
            }
        else break;
        
    }
    return x3; // ret ksi
    
}

int main(int argc, const char * argv[]) {
    double a = 0.1, b = 7, delta_x = 0.05;
    //cout << "\n Answer is "<<AitkenProcessResult(3.9, 0.8, 0.001)<<endl;
    
    for (double x=a;x<b;x+=delta_x)
        if ( sourceFunction(x) * sourceFunction(x+delta_x) <= 0 ) {
            //cout << x << " ";
            cout << "\n Answer is "<< setprecision(15) << AitkenProcessResult(x, 0.9, 1e-8)<<endl;
        }
    cout << it << endl;
    return 0;
}
