//
//  CounterContainer.swift
//  Counting
//
//  Created by Alex Dunn on 2023-11-05.
//

import SwiftUI
import SwiftData

struct CounterListView: View {
    @Environment(\.editMode) var editMode
    @Environment(\.modelContext) private var modelContext
    
    @Query private var counters: [Counter]
    @State var addMode = false
    
    var body: some View {
        NavigationSplitView {
            VStack {
                ScrollView {
                    ForEach(counters) { counter in
                        CounterView(counter: counter)
                    }
                    .onDelete(perform: { indexSet in
                        for i in indexSet {
                            let toDelete = counters[i]
                            modelContext.delete(toDelete)
                        }
                    })
                }
                .toolbar {
                    EditButton()
                    
                    Spacer()
                    
                    Button {
                        // navigate to add
                    } label: {
                        Label("Add new", systemImage: "plus")
                            .labelStyle(.iconOnly)
                    }
                }
                .navigationTitle("Counters")

            }
            .padding()
        } detail: {
            Text("Add New Counter")
        }
    }
}

#Preview {
    CounterListView()
}
