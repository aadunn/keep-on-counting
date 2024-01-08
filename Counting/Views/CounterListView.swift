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
    @State var editMode = EditMode.inactive

    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: [SortDescriptor(\Counter.created, order: .forward)])
    private var allCounters: [Counter]
        
    var body: some View {
        NavigationView {
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
            .environment(\.editMode, $editMode) // binding state editMode to change upon sheet dismiss
            .navigationTitle("Counters")
        }
        .sheet(isPresented: $showNewCounterSheet) {
            EditCounterView(editorTitle: "Add New Counter")
                .onDisappear {
                    setEditModeInactive()
                }
                .onAppear {
                    setEditModeInactive()
                }
        }
    }
    
    private func delete(at indexSet: IndexSet) {
        for i in indexSet {
            let toDelete = allCounters[i]
            modelContext.delete(toDelete)
        }
    }
    
    private func setEditModeInactive() {
        editMode = .inactive
    }
}

#Preview {
    CounterListView()
}
