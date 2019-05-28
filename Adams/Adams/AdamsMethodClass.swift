//
//  AdamsMethodClass.swift
//  Adams
//
//  Created by Иван Романов on 28/05/2019.
//  Copyright © 2019 Иван Романов. All rights reserved.
//

import Foundation

class Adams {
 
    let h: Double = 4e-2, N: Int
    
    let argValues: [Double], resultValues: [[Double]]
    var solutionValues: [[Double]] = []
    
    init(f: (Double, [Double]) -> [Double],
         a: Double, b: Double,
         y0: [Double],
         solution: (Double) -> [Double],//, [Double]),
         size: Int) {
        
        
        N=Int((b-a)/h + 1);
        
        var x = [Double](repeating: 0.0, count: N),
        y = [[Double]](repeating: [0,0,0], count: N)
        
        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        //^^initial
        x[0] = a
        y[0] = [1,-2,0]
        
        // Runge-Kutta Meth
        for funcNumb in 0..<size {
            y[1][funcNumb] = y[0][funcNumb] + h * f( x[0], y[0]) [funcNumb];
        }
        
        for i in 2..<N {
            
            x[i]=a+Double(i)*h;
            
            for funcNumb in 0..<size {
                
                // explicit Adams
                y[i][funcNumb] = y[i-1][funcNumb] + h/2 * ( 3 * f( x[i-1], y[i-1])[funcNumb] - f( x[i-2], y[i-2])[funcNumb] )
            }
            
            for funcNumb in 0..<size {
                
                // implicit Adams
                y[i][funcNumb] = y[i-1][funcNumb] + h/2 * (  f( x[i], y[i])[funcNumb] + f( x[i-1], y[i-1])[funcNumb] )
            }
            
            print(y[i])
            
        }
        
        self.argValues = x
        self.resultValues = y
        
        for i in x {
          self.solutionValues.append(solution(i))
        }

    }
}
