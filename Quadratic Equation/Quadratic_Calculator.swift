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
    func calculateNormalPositive() async -> (Type: String, StringToDisplay: String, Value: Double) {
        normalPositive =  (-b+sqrt(pow(b, 2)-(4*a*c)))/(2*a)
        normalNegative =  (-b-sqrt(pow(b, 2)-(4*a*c)))/(2*a)
    }
    
    
    //    prime          - 2 c
    //  $x      = ------------------$
    //    1,2              __________
    //                  | / 2
    //            b +/- |/ b  - 4 a c
    func calculateAbnormal() {
        abnormalPositive = (-2*c)/(b+sqrt(pow(b, 2)-(4*a*c)))
        abnormalNegative = (-2*c)/(b-sqrt(pow(b, 2)-(4*a*c)))
    }
    
    func calculateSolutions() {
        Task{
            await setButtonEnable(state:false)
            let returnedResults = await withTaskGroup(
                of: (Type: String, StringToDisplay: String, Value: Double).self,
                body: { taskgroup in
                    taskgroup.addTask{ let
                        
                    }
                
            })
        }

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
