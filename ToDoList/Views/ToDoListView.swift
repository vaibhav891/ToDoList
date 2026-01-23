//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Vaibhav Sultania on 12/01/26.
//

import SwiftUI
import SwiftData

struct ToDoListView: View {
    @Query var todos: [ToDo]
    @State private var isSheetVisible = false
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            
            List {
                ForEach(todos) { todo in
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: todo.isCompleted ?  "checkmark.rectangle" :"rectangle")
                                .onTapGesture {
                                    todo.isCompleted.toggle()
                                    guard let _ = try? modelContext.save() else {
                                        print("😡 ERROR: save on toggle did not work")
                                        return
                                    }
                                }
                            NavigationLink {
                                DetailView(toDo: todo)
                            } label: {
                                Text(todo.item)
                            }
                            .swipeActions {
                                Button("Delete", role: .destructive) {
                                    modelContext.delete(todo)
                                    guard let _ = try? modelContext.save() else {
                                        print("😡 ERROR: save on delete did not work")
                                        return
                                    }
                                }
                            }
                        }
                        HStack {
                            Text(todo.dueDate.formatted(date: .abbreviated, time: .shortened))
                                .foregroundStyle(.secondary)
                            if todo.reminderIsOn {
                                Image(systemName: "calendar.badge.clock")
                                    .symbolRenderingMode(.multicolor)
                            }
                            
                        }
                    }
                    
                }
            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
            .sheet(isPresented: $isSheetVisible, content: {
                NavigationStack {
                    DetailView(toDo: ToDo())
                }
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        //TODO: Add a task
                        print("button clicked")
                        isSheetVisible.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}


#Preview {
    ToDoListView()
        .modelContainer(ToDo.preview)
}
