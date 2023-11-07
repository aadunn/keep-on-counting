//
//  CounterView.swift
//  Counting
//
//  Created by Alex Dunn on 2023-11-05.
//

import SwiftUI

struct CounterView: View {
    @State var counter: Counter
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(.black, lineWidth: 1)
                )
                .padding(.horizontal, 8)
            
            HStack {
                Text(counter.title)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
                Text("\(counter.count)")
                    .font(.title)
            }
            .padding(20)
        }
        .onTapGesture {
            counter.increment(amount: 1)
        }
        .onLongPressGesture {
            counter.decrement(amount: 1)
        }
    }
}

#Preview {
    CounterView(counter: Counter(title: "Slips", count: 14))
}
