//
//  TaskRow.swift
//  ToDoDemo (iOS)
//
//  Created by Theoderic onipe on 6/21/22.
//

import SwiftUI

struct TaskRow: View {
    var task: String
    var completed: Bool
    var body: some View {
        HStack(spacing: 20){
            Image(systemName: completed ? "checkmark.circle" : "circle" )
            Text(task)
        }
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(task: "Do Laundry", completed: true)
    }
}
