//
//  NewCounterView.swift
//  Counting
//
//  Created by Alex Dunn on 2023-12-08.
//

import SwiftUI
import SwiftData

struct EditCounterView: View {
    var counter: Counter?
    var editorTitle = "Edit Counter"
    
    @State var title = ""
    @State var count = 0
    @State var backgroundColour: Color = Color.clear
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.editMode) private var editMode
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            Form {
                HStack {
                    TextField("Name", text: $title)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .autocorrectionDisabled()
                        .submitLabel(.done)                
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .listRowInsets(EdgeInsets())

                    TextField("Count", value: $count, format: .number)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                        .submitLabel(.done)
                        .listRowInsets(EdgeInsets())
                }
                .listRowInsets(EdgeInsets())
                .padding()
                .background(backgroundColour)

                ColorPicker(
                    "Colour",
                    selection: $backgroundColour,
                    supportsOpacity: false
                )
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        editMode?.wrappedValue = .inactive
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text(editorTitle)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                }
            }
            .onAppear {
                // fill existing values
                if let counter {
                    title = counter.title
                    count = counter.count
                    backgroundColour = counter.getBackgroundColour()
                }
            }
            
            if let counter {
                Text("Created: \(counter.created.formatted(date: .abbreviated, time: .shortened))")
                Text("Last Updated: \(counter.updated.formatted(date: .abbreviated, time: .shortened))")
            }
        }
    }
    
    private func save() {
        if let counter {
            // editing a counter
            counter.title = title
            counter.count = count
            counter.updated = .now
            
            counter.setBackgroundColour(backgroundColour: backgroundColour)
        } else {
            // adding a counter
            let newCounter = Counter(title: title, count: count)
            modelContext.insert(newCounter)
        }
    }
}

#Preview {
    EditCounterView(counter: Counter(title: "Slips", count: 0))
}
