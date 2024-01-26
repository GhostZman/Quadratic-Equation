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
    func calculateNormal(ain: Double, bin: Double, cin: Double) async -> (PositiveValue: Double, NegativeValue: Double) {
        let calculatedNormalPositive =  (-bin+sqrt(pow(bin, 2)-(4*ain*cin)))/(2*ain)
        let calculatedNormalNegative =  (-bin-sqrt(pow(bin, 2)-(4*ain*cin)))/(2*ain)

        await updateNormalValues(positiveValue: calculatedNormalPositive, negativeValue: calculatedNormalNegative)
        
        return (PositiveValue: calculatedNormalPositive, NegativeValue: calculatedNormalNegative)
    }
    
    
    //    prime          - 2 c
    //  $x      = ------------------$
    //    1,2              __________
    //                  | / 2
    //            b +/- |/ b  - 4 a c
    func calculateAbnormal(ain: Double, bin: Double, cin: Double) async -> (PositiveValue: Double, NegativeValue: Double) {
        let calculatedAbnormalPositive = (-2*cin)/(bin+sqrt(pow(bin, 2)-(4*ain*cin)))
        let calculatedAbnormalNegative = (-2*cin)/(bin-sqrt(pow(bin, 2)-(4*ain*cin)))
        
        await updateAbnormalValues(positiveValue: calculatedAbnormalPositive, negativeValue: calculatedAbnormalNegative)

        return (PositiveValue: calculatedAbnormalPositive, NegativeValue: calculatedAbnormalNegative)
    }
    
    func calculateSolutions() -> Bool{
        
        
        Task{
            await setButtonEnable(state: false)
            let returnedResults = await withTaskGroup(
                of: (PositiveValue: Double, NegativeValue: Double).self,
                returning: [(PositiveValue: Double, NegativeValue: Double)].self,
                body: { taskgroup in
                    taskgroup.addTask{ let normalResults = await self.calculateNormal(ain: self.a, bin: self.b, cin: self.c)
                        return normalResults
                    }
                    taskgroup.addTask{ let abnormalResults = await self.calculateAbnormal(ain: self.a, bin: self.b, cin: self.c)
                        return abnormalResults
                    }
                    var combinedTaskResults :[(PositiveValue: Double, NegativeValue: Double)] = []
                    for await result in taskgroup{
                        combinedTaskResults.append(result)
                    }
                    return combinedTaskResults
            })
            let sortedCombinedResults = returnedResults.sorted(by: { $0.0 < $1.0})
            print(returnedResults)
            print(sortedCombinedResults)
            
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
    @MainActor func updateNormalValues(positiveValue: Double, negativeValue: Double){
        self.normalPositive = positiveValue
        self.normalNegative = negativeValue
    }
    @MainActor func updateAbnormalValues(positiveValue: Double, negativeValue: Double){
        self.abnormalPositive = positiveValue
        self.abnormalNegative = negativeValue
    }
}
