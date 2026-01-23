//
//  DetailView.swift
//  ToDoList
//
//  Created by Vaibhav Sultania on 12/01/26.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @State var toDo: ToDo
    @State private var item = ""
    @State var reminderIsOn = false
    @State var isCompleted = false
//    @State var dueDate = Date.now + 60*60*24
    @State var dueDate = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!
    @State var notes = ""
    @Environment(\.modelContext) var modelContext
    
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        List {
            TextField("Enter To Do here", text: $item)
                .font(.title)
                .textFieldStyle(.roundedBorder)
                .padding(.vertical)
                .listRowSeparator(.hidden)
            
            Toggle("Set Reminder:", isOn: $reminderIsOn)
                .padding(.top)
                .listRowSeparator(.hidden)
            
            DatePicker("Date:", selection: $dueDate)
                .disabled(!reminderIsOn)
            
            Text("Notes:")
                .padding(.top)
                .listRowSeparator(.hidden)
            
            TextField("Notes", text: $notes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .listRowSeparator(.hidden)
            
            Toggle("Completed:", isOn: $isCompleted)
                .padding(.top)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .onAppear(){
            // move data from todo object to local vars
            item = toDo.item
            reminderIsOn = toDo.reminderIsOn
            dueDate = toDo.dueDate
            notes = toDo.notes
            isCompleted = toDo.isCompleted
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
                
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    //From local to object
                     toDo.item = item
                     toDo.reminderIsOn = reminderIsOn
                     toDo.dueDate = dueDate
                     toDo.notes = notes
                     toDo.isCompleted = isCompleted
                    modelContext.insert(toDo)
                    guard let _ = try? modelContext.save() else {
                        print("😡 ERROR: save on detail view did not work")
                        return
                    }
                    dismiss()
                }
            }

        }
        
    }
}

#Preview {
    NavigationStack {
        DetailView(toDo: ToDo())
            .modelContainer(for: ToDo.self, inMemory: true)
    }
}
