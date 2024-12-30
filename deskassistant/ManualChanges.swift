//
//  ManualChanges.swift
//  deskassistant
//
//  Created by Gus Fune on 30/12/2024.
//

import SwiftUI

struct ManualChanges: View {
    @AppStorage("minHeight") var minHeight: Double = 33.1
    @AppStorage("maxHeight") var maxHeight: Double = 40
    @AppStorage("interval") var interval: Int = 30

    public func setHeight(targetHeight: Double) {
        let urlToCall = Bundle.main.object(forInfoDictionaryKey : "UPSIE_DESK_ENDPOINT") as? String ?? ""
        let heightToSet = String(targetHeight)

        var request = URLRequest(url: URL(string: "\(urlToCall)/number/target_desk_height/set?value=\(heightToSet)")!,timeoutInterval: Double.infinity)
        request.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard data != nil else {
            print(String(describing: error))
            return
          }
          print("Can assume it changed height to \(heightToSet)")
            
            UserDefaults.standard.set(targetHeight, forKey: "currentHeight")
            // currentHeight
            let now = Date()
            let intervalInSeconds: TimeInterval = TimeInterval($interval.wrappedValue * 60)
            
            // Add now to interval
            let nextChange = now + intervalInSeconds
            UserDefaults.standard.set(nextChange, forKey: "nextChange")
        }
        
        task.resume()
    }
    
    var body: some View {
        HStack {
            Button("LO") {
                setHeight(targetHeight: minHeight)
            }
            
            Button("HI") {
                setHeight(targetHeight: maxHeight)
            }
                    
            
        }
        .padding(.all)
        .frame(width: 120.0)
    }
}

#Preview {
    ManualChanges()
}
