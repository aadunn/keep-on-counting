//
//  CounterView.swift
//  Counting
//
//  Created by Alex Dunn on 2023-11-05.
//

import SwiftUI

struct CounterView: View {
    @State var counter: Counter
    @State var showEditSheet = false
    
    @Environment(\.editMode) var editMode

    var body: some View {
        HStack {
            Text(counter.title)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            Spacer()
            
            Text("\(counter.count)")
                .font(.title)
        }
        .padding(20)
        .contentShape(Rectangle()) // allows entire view (including Spacer()) to be tapped
        .onTapGesture {
            if editMode?.wrappedValue == .inactive {
                counter.increment(amount: 1)
            } else if editMode?.wrappedValue == .active {
                showEditSheet = true
            }
        }
        .onLongPressGesture {
            if editMode?.wrappedValue == .inactive {
                counter.decrement(amount: 1)
            }
        }
        .sheet(isPresented: $showEditSheet) {
            if editMode?.wrappedValue == .active {
                EditCounterView(counter: counter, editorTitle: "Edit Counter")
                    .onDisappear {
                        // set edit mode to inactive
                        editMode?.wrappedValue = .inactive
                    }
            }
        }
        .background(counter.getBackgroundColour())
    }
}

#Preview {
    CounterView(counter: Counter(
        title: "Slips",
        count: 14,
        backgroundColour: Color.mint.opacity(0.3)
    ))
}
