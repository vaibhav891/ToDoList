//
//  DetailView.swift
//  ToDoList
//
//  Created by Vaibhav Sultania on 12/01/26.
//

import SwiftUI

struct DetailView: View {
    var passedValue: String
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            Image(systemName: "swift")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.orange)
            
            Text("You are a swifty legend!\nYou passed \(passedValue)")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Spacer()
            Button("Get Back!") {
                dismiss()
            }
            .buttonStyle(.glassProminent)
            
        }
        .padding()
    }
}

#Preview {
    DetailView(passedValue: "List 1")
}
