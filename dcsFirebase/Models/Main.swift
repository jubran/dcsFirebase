//
//  Main.swift
//  figmaSwift
//
//  Created by جبران on 04/01/2024.
//


import Foundation
import SwiftUI
import SwiftData
import CoreData


@Model
class ToDoItem:Identifiable
{
    @Attribute(.unique) let id = UUID()
    var name: String
    var priorityNum: String
    var isComplete: Bool
    
    init(name: String , priorityNum: String  , isComplete: Bool ) {
        self.name = name
        self.priorityNum = priorityNum
        self.isComplete = isComplete
    }
}
struct ShipmentId: Identifiable,Hashable {
    var id = UUID().uuidString
    var location: String
    var name:String
//    var event: String
//    var date: Date
//    var time: Date
//    var fsnl: Date
//    var synch: Date
    var priorityId: Priority
  
}
enum Priority: String {
        case low = "1"
        case normal = "2"
        case high = "3"
    
}
var todoItems:[ToDoItem] = [
    ToDoItem(name: "jobran", priorityNum: "2", isComplete: false),
    ToDoItem(name: "yahya", priorityNum: "2", isComplete: false),
    ToDoItem(name: "sami", priorityNum: "2", isComplete: false)

]
var shipDemo:[ShipmentId] = [
    ShipmentId(location: "Jedah", name: "jobran", priorityId: .high)
]
