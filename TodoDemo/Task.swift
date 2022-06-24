//
//  Task.swift
//  ToDoDemo (iOS)
//
//  Created by Theoderic onipe on 6/23/22.
//

import Foundation
import RealmSwift

class Task: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title = ""
    @Persisted var completed = false
}
