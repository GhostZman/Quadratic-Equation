//
//  ContentView.swift
//  Quadratic Equation
//
//  Created by Phys440Zachary on 1/19/24.
//

import SwiftUI

struct ContentView: View {
    @Bindable var myQuadraticCalculator = Quadratic_Calculator()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
