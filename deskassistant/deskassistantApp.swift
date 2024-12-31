//
//  deskassistantApp.swift
//  deskassistant
//
//  Created by Gus Fune on 30/12/2024.
//

import SwiftUI
import Foundation

@available(macOS 15.0, *)
@main
struct deskassistantApp: App {
    @AppStorage("enabled") var enabled: Bool = false

    var body: some Scene {
        MenuBarExtra("Utility App", systemImage: $enabled.wrappedValue ? "lamp.desk.fill" : "lamp.desk") {
            TimelineView(.periodic(from: Date(), by: 60.0), content: { TimelineViewDefaultContext in
                AppMenu()
            })
        }
        .menuBarExtraStyle(.window)

    }
}
