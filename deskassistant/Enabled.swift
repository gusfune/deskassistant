//
//  Enabled.swift
//  deskassistant
//
//  Created by Gus Fune on 30/12/2024.
//

import SwiftUI

struct Enabled: View {
    @AppStorage("enabled") var enabled: Bool = false
    
    var body: some View {
        Toggle(isOn: $enabled) {
            Text("Enabled?")
        }.padding(.all).onChange(of: enabled) { oldValue, newValue in
            print("User toggled enabled to \(newValue)")
            UserDefaults.standard.set(newValue, forKey: "enabled")
        }
    }
}

#Preview {
    Enabled()
}
