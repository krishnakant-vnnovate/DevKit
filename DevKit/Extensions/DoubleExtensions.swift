//
//  DoubleExtensions.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public extension Double {
    
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func round(nearest: Double) -> Double {
        let n = 1/nearest
        let numberToRound = self * n
        return numberToRound.rounded() / n
    }
    
    // HERE BE DRAGONS: PORTED LEGACY CODE
    func prettify(withDivisions: Int) -> Double {
        let maxNumberInt = Int(self)
        var numbersMask = 1
        
        if maxNumberInt < 10 {
            numbersMask = 1
        } else {
            var loop = 50
            numbersMask = 15
            
            loop -= 1
            while loop > 0 {
                var innerI = 1
                
                while innerI < 10 {
                    if maxNumberInt < numbersMask * 10 * innerI {
                        numbersMask *= innerI
                        loop = 0
                        break
                    }
                    
                    innerI *= 2
                }
                
                if loop > 0 {
                    numbersMask *= 10
                }
            }
        }
        
        return Double((Int(self + Double(numbersMask)) / numbersMask) * numbersMask)
    }
    
    func string(minFractionDigits: Int, maxFractionDigits: Int) -> String {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = minFractionDigits
        formatter.maximumFractionDigits = maxFractionDigits
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
    
}
