//
//  Counter.swift
//  Counting
//
//  Created by Alex Dunn on 2023-11-06.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Counter: Identifiable {
    @Attribute(.unique) var id: String
    var title: String
    var count: Int
    var highestCount: Int = 0
    var created: Date = Date()
    var updated: Date = Date()
    var red: Double = 255 / 255
    var green: Double = 255 / 255
    var blue: Double = 255 / 255
    var opacity: Double = 0.2
    
    init(title: String, count: Int) {
        self.id = UUID().uuidString
        self.title = title
        self.count = count
        self.highestCount = count
        self.created = .now
        self.updated = .now
        self.red = 255 / 255
        self.green = 255 / 255
        self.blue = 255 / 255
        self.opacity = 0.2
    }
    
    init(title: String, count: Int, backgroundColour: Color) {
        self.id = UUID().uuidString
        self.title = title
        self.count = count
        self.highestCount = count
        self.created = .now
        self.updated = .now
        
        let resolvedColour = backgroundColour.resolve(in: EnvironmentValues())
        
        self.red = Double(resolvedColour.red)
        self.green = Double(resolvedColour.green)
        self.blue = Double(resolvedColour.blue)
    }
    
    init(count: Int) {
        self.id = UUID().uuidString
        self.title = ""
        self.count = count
        self.highestCount = count
        self.created = .now
        self.updated = .now
        self.red = 255 / 255
        self.green = 255 / 255
        self.blue = 255 / 255
        self.opacity = 0.3
    }
    
    init() {
        self.id = UUID().uuidString
        self.title = ""
        self.count = 0
        self.highestCount = 0
        self.created = .now
        self.updated = .now
        self.red = 255 / 255
        self.green = 255 / 255
        self.blue = 255 / 255
        self.opacity = 0.3
    }
    
    func increment(amount: Int) {
        count += amount
    }
    
    func decrement(amount: Int) {
        count -= amount
    }
    
    func increment() {
        count += 1
    }
    
    func decrement() {
        count -= 1
    }
    
    func getBackgroundColour() -> Color {
        return Color(
            red: self.red,
            green: self.green,
            blue: self.blue,
            opacity: self.opacity
        )
    }
    
    func setBackgroundColour(backgroundColour: Color) {
        let resolvedColour = backgroundColour.resolve(in: EnvironmentValues())
        
        self.red = Double(resolvedColour.red)
        self.green = Double(resolvedColour.green)
        self.blue = Double(resolvedColour.blue)
    }
}
