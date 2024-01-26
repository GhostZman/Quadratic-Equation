//
//  ContentView.swift
//  Quadratic Equation
//
//  Created by Phys440Zachary on 1/19/24.
//

import SwiftUI

struct ContentView: View {
    @Bindable var myQuadraticCalculator = Quadratic_Calculator()
    @State var aString = "1.0"
    @State var bString = "1.0"
    @State var cString = "0.1"
    var body: some View {
        VStack {
            HStack{
                Text("a: ")
                TextField("Enter a ...", text:$aString)
                Text("b: ")
                TextField("Enter b ...", text:$bString)
                Text("c: ")
                TextField("Enter c ...", text:$cString)
            }
            HStack{
                VStack{
                    Text("Normal Positive: ")
                    Text("\(myQuadraticCalculator.normalPositive, specifier: "%.20f")")
                    Text("Abnormal Positive: ")
                    Text("\(myQuadraticCalculator.abnormalPositive, specifier: "%.20f")")
                }
                VStack{
                    Text("Normal Negative: ")
                    Text("\(myQuadraticCalculator.normalNegative, specifier: "%.20f")")
                    Text("Abnormal Negative: ")
                    Text("\(myQuadraticCalculator.abnormalNegative, specifier: "%.20f")")
                }
            }
            Button("Calculate", action: {self.calculate()})
                .disabled(myQuadraticCalculator.enableButton == false)
        }
        .padding()
    }
    func calculate(){
        myQuadraticCalculator.enableButton = false
        let _ : Bool = myQuadraticCalculator.initWithVariables(inputa: Double(aString)!, inputb: Double(bString)!, inputc: Double(cString)!)
    }
}

#Preview {
    ContentView()
}
