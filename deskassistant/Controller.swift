//
//  Controller.swift
//  deskassistant
//
//  Created by Gus Fune on 30/12/2024.
//

import Foundation
import SwiftUI

class Controller {
    private var enabled: Binding<Bool>
    private var nextChange: Binding<Date?>
    private var minHeight: Binding<Double>
    private var maxHeight: Binding<Double>
    private var apiEndpoint: String
    private var interval: Binding<Int>
    private var currentHeight: Double?
    private var startTime: Binding<Int>
    private var endTime: Binding<Int>
    
    
    init(
        enabled: Binding<Bool>,
        nextChange: Binding<Date?>,
        minHeight: Binding<Double>,
        maxHeight: Binding<Double>,
        interval: Binding<Int>,
        startTime: Binding<Int>,
        endTime: Binding<Int>
    ) {
        self.enabled = enabled
        self.nextChange = nextChange
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self.apiEndpoint = Bundle.main.object(forInfoDictionaryKey : "UPSIE_DESK_ENDPOINT") as? String ?? ""
        self.interval = interval
        self.startTime = startTime
        self.endTime = endTime
    }

    
    // Check for current height
    public func checkHeight() {
        
        let urlToCall = self.apiEndpoint
        print("Starting height check on \(urlToCall)")
        
        var request = URLRequest(url: URL(string: "\(self.apiEndpoint)/sensor/desk_height")!,
                                 timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            let decodedData = try! JSONDecoder().decode(DeskHeightResponse.self, from: data)
            
            print(String(data: data, encoding: .utf8)!)
            
            // SET HERE THE DETAILS
            let currentValue = decodedData.value
            print("Got the current height as \(currentValue)")
            UserDefaults.standard.set(currentValue, forKey: "currentHeight")
            self.currentHeight = currentValue
        }
        
        task.resume()
    }
    
    public func setHeight(targetHeight: Double) {
        let urlToCall = self.apiEndpoint
        let heightToSet = String(targetHeight)

        var request = URLRequest(url: URL(string: "\(urlToCall)/number/target_desk_height/set?value=\(heightToSet)")!,timeoutInterval: Double.infinity)
        request.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard data != nil else {
            print(String(describing: error))
            return
          }
          print("Can assume it changed height to \(heightToSet)")
            self.currentHeight = targetHeight
            
            UserDefaults.standard.set(targetHeight, forKey: "currentHeight")
            // currentHeight
            let now = Date()
            let intervalInSeconds: TimeInterval = TimeInterval(self.interval.wrappedValue * 60)
            
            // Add now to interval
            let nextChange = now + intervalInSeconds
            UserDefaults.standard.set(nextChange, forKey: "nextChange")
        }
        
        task.resume()
    }
    
    private func decideHeight() -> Double {
        let currentHeight = self.currentHeight ?? 35
        let lowHeight = self.minHeight.wrappedValue
        let highHeight = self.maxHeight.wrappedValue
        
        let diffLow = abs(currentHeight - lowHeight)
        let diffHeight = abs(currentHeight - highHeight)
        let diff = diffLow <= diffHeight ? 0 : 1
        print("Current setting is \(diff == 0 ? "low" : "high")")
        
        return diff < 0 ? lowHeight : highHeight
    }
    
    public func run() {
        print("running")
        
        self.checkHeight()
        
        // Check if enabled
        if ( self.enabled.wrappedValue == false ) {
            return print("Desk Assistant is disabled")
        }
        
        // Check if next date is past or future
        let now = Date()
        var nextChangeDate = self.nextChange.wrappedValue
        
        if ( nextChangeDate == nil ) {
            nextChangeDate = now
        }
        print("now is \(now.description)")
        print("next change date is \(nextChangeDate?.description ?? "nil")")
        
        // If Future stops
        if ( nextChangeDate?.timeIntervalSinceNow.sign == .plus ) {
            return print("Desk Assistant is not due yet")
        }
        
        // Check if it's past early time and ealier than end time
        let calendar = Calendar(identifier: .gregorian)
        let startDatetime = calendar.date(from: DateComponents(hour: self.startTime.wrappedValue, minute: 0))
        let endDatetime = calendar.date(from: DateComponents(hour: self.endTime.wrappedValue, minute: 0))

        if ( startDatetime?.timeIntervalSinceNow.sign == .plus && endDatetime?.timeIntervalSinceNow.sign == .minus ) {
            return print("Desk Assistant is outside working hours")
        }
        
        print("Deciding current height")
        // Make the change and set date for next interval
        let newValue = self.decideHeight()
        print("Setting new height to \(newValue)")
        self.setHeight(targetHeight: newValue)
        

    }
    
}
