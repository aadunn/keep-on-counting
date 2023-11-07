//
//  Counter.swift
//  Counting
//
//  Created by Alex Dunn on 2023-11-06.
//

import Foundation
import SwiftData

@Model
class Counter: Identifiable {
    @Attribute(.unique) var id: String
    var title: String
    var count: Int
    var highestCount: Int = 0
    var created: Date = Date()
    var updated: Date = Date()
    
    init(title: String, count: Int) {
        self.id = UUID().uuidString
        self.title = title
        self.count = count
        self.highestCount = count
        self.created = Date()
        self.updated = Date()
    }
    
    func increment(amount: Int) {
        count += amount
    }
    
    func decrement(amount: Int) {
        count -= amount
    }
}
