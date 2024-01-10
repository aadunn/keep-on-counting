//
//  CounterDetailView.swift
//  Counting
//
//  Created by Alex Dunn on 2024-01-08.
//

import SwiftUI

struct CounterDetailView: View {
    var counter: Counter
    
    @State var incrementBy: Int = 1
    @State var decrementBy: Int = 1
    
    var body: some View {
        Text("\(counter.title)")
            .font(.largeTitle)
            .bold()
        
        VStack(alignment: .leading) {
            ZStack {
                Circle()
                    .fill(Color(red: 30 / 255, green: 255 / 255, blue: 30 / 255, opacity: 0.3))
                    .stroke(.black, lineWidth: 8)
                    .contentShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                
                Text("+ \(incrementBy)")
                    .font(.system(size: 50))
            }
            .padding()
            
            HStack {
                ZStack {
                    Circle()
                        .fill(Color(red: 255, green: 0, blue: 0, opacity: 0.5))
                        .stroke(.black, lineWidth: 8)
                        
                    Text("- \(decrementBy)")
                        .font(.system(size: 30))
                }
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100, alignment: .leading)
            }
        }
        .padding(40)
    }
}

#Preview {
    CounterDetailView(counter: Counter(title: "Slips", count: 11))
}
