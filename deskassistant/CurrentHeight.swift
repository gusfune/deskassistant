//
//  CurrentHeight.swift
//  deskassistant
//
//  Created by Gus Fune on 30/12/2024.
//

import SwiftUI

struct CurrentHeight: View {
    @AppStorage("currentHeight") var currentHeight: Int?

    var body: some View {
        if (currentHeight != nil && currentHeight! > 0) {
            Text("Current height: \(String($currentHeight.wrappedValue!)) ")
        } else {
            Text("Current height: ??")

        }
    }
}

#Preview {
    CurrentHeight()
}
