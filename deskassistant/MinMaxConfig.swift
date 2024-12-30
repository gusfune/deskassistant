//
//  MinMaxConfig.swift
//  deskassistant
//
//  Created by Gus Fune on 30/12/2024.
//

import SwiftUI

struct MinMaxConfig: View {
    @AppStorage("minHeight") var minHeight: Double = 33.1
    @AppStorage("maxHeight") var maxHeight: Double = 40
    @AppStorage("interval") var interval: Int = 30
    
    var body: some View {
        HStack {
            VStack(spacing: 1.0) {
                Text("MIN")
                TextField(
                    "Min",
                    value: $minHeight,
                    format: .number
                ).onChange(of: minHeight) { oldValue, newValue in
                    if newValue < maxHeight {
                        minHeight = newValue
                        print("User changed min height to \(newValue)")
                        UserDefaults.standard.set(newValue, forKey: "minHeight")
                    } else {
                        print("Could not change value to \(newValue), max height is \(maxHeight).")
                        minHeight = oldValue
                    }
                }
            }
            .padding(.vertical)
            
            VStack(spacing: 1.0) {
                Text("MAX")
                TextField(
                    "Max",
                    value: $maxHeight,
                    format: .number
                ).onChange(of: maxHeight) { oldValue, newValue in
                    if newValue > minHeight {
                        maxHeight = newValue
                        print("User changed max height to \(newValue)")
                        UserDefaults.standard.set(newValue, forKey: "maxHeight")
                    } else {
                        print("Could not change value to \(newValue), min height is \(minHeight).")
                        maxHeight = oldValue
                    }
                }
            }
            .padding(.vertical)
            
            VStack(spacing: 1.0) {
                Text("LOOP")
                TextField(
                    "LOOP",
                    value: $interval,
                    format: .number
                ).onChange(of: interval) { oldValue, newValue in
                    interval = newValue
                    print("User changed interval to \(newValue)")
                    UserDefaults.standard.set(newValue, forKey: "interval")
                }
            }
            .padding(.vertical)
        }
        .padding(.horizontal)
        .frame(width: 180.0)
    }
}

#Preview {
    MinMaxConfig()
}
