//
//  PeriodSetter.swift
//  deskassistant
//
//  Created by Gus Fune on 30/12/2024.
//

import SwiftUI

struct PeriodSetter: View {
    @AppStorage("interval") var interval: Int = 30
    
    var body: some View {
        HStack(spacing: 1.25) {
            Text("Run")
            TextField(
                "min",
                value: $interval,
                format: .number
            ).onChange(of: interval) { oldValue, newValue in
                if newValue > 1 {
                    interval = newValue
                    print("User changed interval to \(newValue)")
                    UserDefaults.standard.set(newValue, forKey: "interval")
                } else {
                    print("Could not change value to \(newValue)")
                    interval = oldValue
                }
            }
            Text("min")
        }
        .padding(.all)
        .frame(width: 120.0)
    }
}

#Preview {
    PeriodSetter()
}
