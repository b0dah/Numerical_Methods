//
//  main.cpp
//  NM_Integration
//
//  Created by Иван Романов on 13/02/2019.
//  Copyright © 2019 Иван Романов. All rights reserved.
//

#include <iostream>
#include "math.h"

using namespace std;

double a=0, b=1, n=1000;

double sourceFunction(double x) {
    //return x*x;
    //return sin(x);
    // return x-1;
    return (5*x*x*x*x - 3*x*x + 1);
}

double Integrate(double a, double b, double n){
    double summ = 0, h = (b-a)/n;
    
    for (double cur_arg = a + h/2; cur_arg < b; cur_arg+=h) // center
        summ += sourceFunction(cur_arg);
    
    summ*=h;
    return summ;
}

int main(int argc, const char * argv[]) {
    // insert code here...
    /*cout << "enter a"<<endl;
    cin >> a;
    
    cout << "enter b"<<endl;
    cin >> b;
    
    cout << "enter n"<<endl;
    cin >> n; */
    
    cout << "The answer is  " << Integrate(a,b,n) << endl;
    return 0;
}
