//
//  ToDo.swift
//  ToDoList
//
//  Created by anthony on 7/8/17.
//  Copyright © 2017 Casandra Hayward. All rights reserved.
//

import Foundation
import UIKit
class ToDo: NSObject{
    
    //PROPERTIES
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    var image: UIImage?
    
    //INITIALIZER
    init(title: String, isComplete: Bool, dueDate: Date, notes: String?, image: UIImage){
        guard !title.isEmpty else {
            fatalError("Reminder requires a non-empty titel")
            
        }
        
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.notes = notes
        self.image = image
    }
    
    //METHODS
    
    //Type Methods to Load Data onto Table View
    static func loadToDos() -> [ToDo]? {
        return nil
    }
    
    static func loadSampleTableViewItems() -> [ToDo] {
        let walkDog = ToDo(title: "Walk Dog", isComplete: true, dueDate: Date(), notes: "Remind Chadwell", image:#imageLiteral(resourceName: "lsuStadium"))
        
        let store = ToDo(title: "Go to store", isComplete: false, dueDate: Date(), notes: "See grocery list", image: #imageLiteral(resourceName: "lsuStadium"))
        return [walkDog, store]
    }
    
    //Type Method for date formatter
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    
}
