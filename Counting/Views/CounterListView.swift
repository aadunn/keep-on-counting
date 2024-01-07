//
//  CounterContainer.swift
//  Counting
//
//  Created by Alex Dunn on 2023-11-05.
//

import SwiftUI
import SwiftData

struct CounterListView: View {
    @State var showNewCounterSheet = false
    
    @Environment(\.addMode) var addMode
    @Environment(\.editMode) var editMode
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: [SortDescriptor(\Counter.created, order: .reverse)])
    private var allCounters: [Counter]
    
    var body: some View {
        NavigationSplitView {
                List {
                    ForEach(allCounters) { counter in
                        CounterView(counter: counter)
                            .listRowInsets(EdgeInsets())
                    }
                    .onDelete(perform: delete)
                }
                .listStyle(.plain)
                .padding(EdgeInsets(.zero))
                .toolbar {
                    ToolbarItem(placement: .cancellationAction){
                        EditButton()
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button {
                            showNewCounterSheet = true
                        } label: {
                            Label("Add new", systemImage: "plus")
                                .labelStyle(.iconOnly)
                        }
                    }
                }
                .navigationTitle("Counters")
            
        } detail: {
            Text("List of counters")
        }
        .sheet(isPresented: $showNewCounterSheet) {
            if editMode?.wrappedValue == .inactive {
                EditCounterView(editorTitle: "Add New Counter")
            }
        }
    }
    
    private func delete(at indexSet: IndexSet) {
        for i in indexSet {
            let toDelete = allCounters[i]
            modelContext.delete(toDelete)
        }
    }
}

#Preview {
    CounterListView()
}
