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
    var body: some View {
        NavigationStack {
            List {
                ForEach(ExampleTask().tasklist, id: \.self) { task in
                        Text(task)
                }
            }
            .navigationTitle("Task List")
        }
        .padding()
    }
}
struct SecondView: View {
    @State var task: String = ""
    
    var body: some View {
          TextField("Enter your task", text: $task)
              .textFieldStyle(.roundedBorder)
              .padding()
        Button {
            //
        } label: {
            Text("Add")
        }
        .buttonStyle(.borderedProminent)
        .tint(.orange)
        .padding()
        
        Spacer()
        
        
    }
}

#Preview("SecondView") {
    SecondView()
}
