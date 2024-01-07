//
//  CountingApp.swift
//  Counting
//
//  Created by Alex Dunn on 2023-11-05.
//

import SwiftUI
import SwiftData

private struct AddModeKey: EnvironmentKey {
  static let defaultValue = false
}

extension EnvironmentValues {
  var addMode: Bool {
    get { self[AddModeKey.self] }
    set { self[AddModeKey.self] = newValue }
  }
}

@main
struct CountingApp: App {
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: Counter.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
        }
    }
}
