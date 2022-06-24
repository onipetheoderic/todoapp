//
//  AddTaskView.swift
//  ToDoDemo (iOS)
//
//  Created by Theoderic onipe on 6/21/22.
//

import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var realmManager: RealmManager
    @State private var title: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text("Create a new task")
                .font(.title3).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("Enter your task here", text:$title)
                .textFieldStyle(.roundedBorder)
            Button {
                if title != ""{
                    realmManager.addTask(taskTitle: title)
                }
               
                
            } label:{
                Text("Add task")
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(Color(hue:0.328, saturation: 0.796, brightness: 0.408))
                    .cornerRadius(30)
            }
            Spacer()
        }
        .padding(.top, 40)
        .padding(.horizontal)
        .background(Color(hue:0.086, saturation: 0.242, brightness: 0.941))
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
            .environmentObject(RealmManager())
    }
}
