//
//  Quadratic_Calculator.swift
//  Quadratic Equation
//
//  Created by Phys440Zachary on 1/19/24.
//

import SwiftUI
import Observation

@Observable class Quadratic_Calculator{
    var a = 1.0
    var b = 4.0
    var c = 1.0
    var normalPositive = 0.0
    var normalNegative = 0.0
    var abnormalPositive = 0.0
    var abnormalNegative = 0.0
    var enableButton = true
    
    func initWithVariables(inputa:Double, inputb:Double, inputc:Double) {
        self.a = inputa
        self.b = inputb
        self.c = inputc
    }
    
    
    //                    __________
    //                 | / 2
    //         - b +/- |/ b  - 4 a c
    //$$x    = ---------------------$$
    //  1,2            2 a
    func calculateNormal() async -> (PositiveValue: Double, NegativeValue: Double) {
        self.normalPositive =  (-b+sqrt(pow(b, 2)-(4*a*c)))/(2*a)
        self.normalNegative =  (-b-sqrt(pow(b, 2)-(4*a*c)))/(2*a)

        return (PositiveValue: normalPositive, NegativeValue: normalNegative)
    }
    
    
    //    prime          - 2 c
    //  $x      = ------------------$
    //    1,2              __________
    //                  | / 2
    //            b +/- |/ b  - 4 a c
    func calculateAbnormal() async -> (PositiveValue: Double, NegativeValue: Double) {
        self.abnormalPositive = (-2*c)/(b+sqrt(pow(b, 2)-(4*a*c)))
        self.abnormalNegative = (-2*c)/(b-sqrt(pow(b, 2)-(4*a*c)))

        return (PositiveValue: abnormalPositive, NegativeValue: abnormalNegative)
    }
    
    func calculateSolutions() {
        Task{
            await setButtonEnable(state:false)
            let returnedResults = await withTaskGroup(
                of: (PositiveValue: Double, NegativeValue: Double).self,
                body: { taskgroup in
                    taskgroup.addTask{ let normalResults = await self.calculateNormal()
                        return normalResults
                    }
                    taskgroup.addTask{ let abnormalResults = await self.calculateAbnormal()
                        return abnormalResults
                    }
                    var combinedTaskResults :[PositiveNormal: Double, NegativeNormal: Double, PositiveAbnormal: Double, NegativeAbnormal: Double] = []
                    for await result in taskGroup{
                        combinedTaskResults.append(result[0])
                        combinedTaskResults.append(result[1])
                    }
                    return combinedTaskResults
            })
            print(returnedResults)

            await setButtonEnable(state: true)
        }
        return true
    }
    @MainActor func setButtonEnable(state: Bool){
        
        if state {
            Task.init {
                await MainActor.run {
                    
                    
                    self.enableButton = true
                }
            }
        }
        else{
            Task.init {
                await MainActor.run{
                    self.enableButton = false
                }
            }
        }
    }
    
}
