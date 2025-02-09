//
//  TaskList.swift
//  ListView
//
//  Created by 佐藤幸久 on 2025/02/09.
//

import Foundation

struct ExampleTask {
    let tasklist = [
        "掃除",
        "洗濯",
        "料理",
        "買い物",
        "読書",
        "運動"
    ]
}

struct Task: Codable {
    var id = UUID()
    var taskItem: String
}
