//
//  AppMenu.swift
//  deskassistant
//
//  Created by Gus Fune on 30/12/2024.
//

import SwiftUI

@available(macOS 15.0, *)
struct AppMenu: View {
    @AppStorage("startTime") var startTime: Int = 9
    @AppStorage("endTime") var endTime: Int = 17
    @AppStorage("interval") var interval: Int = 30
    @AppStorage("enabled") var enabled: Bool = false
    @AppStorage("minHeight") var minHeight: Double = 33.1
    @AppStorage("maxHeight") var maxHeight: Double = 40.0
    @AppStorage("nextChange") var nextChange: Date?
    
    let timer = Timer.publish(every: 60.0, on: .main, in: .common).autoconnect()
    
    func run() {
        print("tick")
        let control = Controller(
            enabled: $enabled,
            nextChange: $nextChange,
            minHeight: $minHeight,
            maxHeight: $maxHeight,
            interval: $interval,
            startTime: $startTime,
            endTime: $endTime
        )
        control.run()
    }
    
    init () {
        print("this is the init function")
        let control = Controller(
            enabled: $enabled,
            nextChange: $nextChange,
            minHeight: $minHeight,
            maxHeight: $maxHeight,
            interval: $interval,
            startTime: $startTime,
            endTime: $endTime
        )
        control.run()
    }
    
    var body: some View {
        VStack(spacing: 1.0) {
            Image(systemName: "studentdesk")
                .resizable(resizingMode: .stretch)
                .frame(width: 32.0, height: 32.0)
            
            Text("Desk Assistant")
                .font(.title2)
                .onReceive(timer) { _ in
                    self.run()
                }

            Enabled()
               
            CurrentHeight()
            
            MinMaxConfig()
            
            ManualChanges()
            
            HStack {
                Text("Next change: \($nextChange.wrappedValue?.formatted() ?? "none")")

                Button {
                    self.run()
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 16.0, height: 16.0) .padding(.all, 0.5)
                }
                
                Button {
                    exit(0)
                } label: {
                    Image(systemName: "xmark")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 16.0, height: 16.0) .padding(.all, 0.5)
                }
            }
            
            
            
        }
        .padding(.all)
      
        
    }
}

#Preview {
    if #available(macOS 15.0, *) {
        AppMenu()
    } else {
        // Fallback on earlier versions
    }
}
