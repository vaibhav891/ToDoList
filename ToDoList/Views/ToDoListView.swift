//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Vaibhav Sultania on 12/01/26.
//

import SwiftUI
import SwiftData

enum SortOptions: String, CaseIterable   {
    case asEntered = "As Entered";
    case alphabetical = "A-Z";
    case chronological = "Date"
    case completed = "Not Done"
    
}

struct SortedToDoListView: View {
    @Query var todos: [ToDo]
    @Environment(\.modelContext) var modelContext
    let sortSelection: SortOptions
    
    init(sortSelection: SortOptions) {
        self.sortSelection = sortSelection
        switch sortSelection {
        case .asEntered: _todos = Query()
        case .alphabetical: _todos = Query(sort: \.item)
        case .chronological: _todos = Query(sort: \.dueDate)
        case .completed: _todos = Query(filter: #Predicate {$0.isCompleted == false})
        }
    }
    
    var body: some View {
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
        .listStyle(.plain)
    }
}

struct ToDoListView: View {
    
    @State private var isSheetVisible = false
    @State private var sortSelection: SortOptions = .asEntered
    
    
    var body: some View {
        NavigationStack {
            SortedToDoListView(sortSelection: sortSelection)
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
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
                ToolbarItem(placement: .bottomBar) {
                    Picker("", selection: $sortSelection) {
                        ForEach(SortOptions.allCases, id: \.self) { sortOrder in
                            Text(sortOrder.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
    }
}


#Preview {
    ToDoListView()
        .modelContainer(ToDo.preview)
}
