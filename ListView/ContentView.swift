//
//  ContentView.swift
//  ListView
//
//  Created by 佐藤幸久 on 2025/02/09.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        FirstView()
    }
}

struct FirstView: View {
      @AppStorage("TasksData") private var tasksData = Data()
      // タスクを入れておくための配列
      @State var tasksArray: [Task] = []
    
    init() {
        if let decodedTasks = try? JSONDecoder().decode([Task].self, from: tasksData) {
            _tasksArray = State(initialValue: decodedTasks)
            print(tasksArray)
        }
    }
    
    var body: some View {
        NavigationStack {
            NavigationLink(destination: SecondView(tasksArray: $tasksArray).navigationTitle("Add Task")) {
                Text("Add New Task")
                .font(.system(size: 20, weight: .bold))
                .padding()
            }
            List {
                ForEach(tasksArray) { task in
                    Text(task.taskItem)
                }
                .onMove(perform: { from, to in
                    replaceRow(from, to)
                })
            }
            .navigationTitle("Task List")
            
            .toolbar(content: {
                EditButton()
            })
        }
        .padding()
    }
    func replaceRow(_ from: IndexSet, _ to: Int) {
        tasksArray.move(fromOffsets: from, toOffset: to)
        if let encodedArray = try? JSONEncoder().encode(tasksArray) {
            tasksData = encodedArray
        }
    }
}
struct SecondView: View {
    @Environment(\.dismiss) private var dismiss
    @State var task: String = ""
    
    @Binding var tasksArray: [Task]
    
    var body: some View {
          TextField("Enter your task", text: $task)
              .textFieldStyle(.roundedBorder)
              .padding()
        Button {
            addTask(newTask: task)
            task = ""
            print(tasksArray)
        } label: {
            Text("Add")
        }
        .buttonStyle(.borderedProminent)
        .tint(.orange)
        .padding()
        
        Spacer()
        
        
    }
    func addTask(newTask: String) {
        if !newTask.isEmpty {
            let task = Task(taskItem: newTask)
            var array = tasksArray
            array.append(task)
            
            if let encodedData = try? JSONEncoder().encode(array) {
                UserDefaults.standard.setValue(encodedData, forKey: "TasksData")
                tasksArray = array
                dismiss()
            }
        }
    }
}

//#Preview("Second View") {
//    SecondView(tasksArray: FirstView().$tasksArray)
//}
