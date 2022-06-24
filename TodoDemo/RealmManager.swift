//
//  RealmManager.swift
//  ToDoDemo (iOS)
//
//  Created by Theoderic onipe on 6/21/22.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?
    @Published private(set) var tasks: [Task] = []
    
    init(){
        openRealm()
        getTasks()
    }
    
    func openRealm(){
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config//the local realm we just created
            localRealm = try Realm()
        } catch{
            print("Error opening Realm: \(error)")
        }
    }
    func addTask(taskTitle: String){
        if let localRealm = localRealm {
            do {
                try localRealm.write{
                    let newTask = Task(value: ["title":taskTitle, "completed": false])
                    localRealm.add(newTask)
                    getTasks()//we update the task array each time after adding a new task
                    print("Added new Task to Realm: \(newTask)")
                }
            } catch {
                print("Error adding task to Realm: \(error)")
            }
        }
    }
    
    func getTasks(){
        if let localRealm = localRealm {
            let allTasks = localRealm.objects(Task.self).sorted(byKeyPath: "completed")
            tasks = []
            allTasks.forEach {
                task in tasks.append(task)
            }
        }
    }
    
    func updateTask(id: ObjectId, completed: Bool){
        if let localRealm = localRealm {
            do {
                let taskToUpdate = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))//this would filter all the task and only return us the task we want to parse
                guard !taskToUpdate.isEmpty else { return }//check if its not empty
                
                try localRealm.write {
                    taskToUpdate[0].completed = completed
                    getTasks()
                    print("Updated task with id \(id)! Completed Status: \(completed)")
                }
            }
            catch {
                print("Error updating task \(id) to Realm: \(error)")
            }
        }
    }
    
    func deleteTask(id: ObjectId){
        if let localRealm = localRealm {
            do {
                let taskToDelete = localRealm.objects(Task.self).filter(NSPredicate(format:"id== %@", id))
                guard !taskToDelete.isEmpty else {return}
                
                try localRealm.write {
                    localRealm.delete(taskToDelete)
                    getTasks()
                    print("Deleted task with id \(id)")
                }
            }catch{
                print("Error deleting task \(id) from Realm: \(error)")
            }
        }
    }
    
    
}
