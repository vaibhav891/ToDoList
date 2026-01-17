//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Vaibhav Sultania on 12/01/26.
//

import SwiftUI

struct ToDoListView: View {
    var todos = ["Learn Swift", "Build Apps", "Change the World","Bring the Awesome", "Take a Vacation"]
    var body: some View {
        NavigationStack {
            List {
                ForEach(todos, id: \.self) { todo in
                    NavigationLink {
                        DetailView(passedValue: todo)
                    } label: {
                        Text(todo)
                    }
                    
                }
            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
        }
    }
}


#Preview {
    ToDoListView()
}
