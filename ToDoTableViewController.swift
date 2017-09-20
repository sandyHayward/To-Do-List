//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by anthony on 7/8/17.
//  Copyright © 2017 Casandra Hayward. All rights reserved.
//

import UIKit
import Foundation
 
//when tap on √ toggles isComplete but when click on > segues to AddTVC
//save before segue to AddTVC
class ToDoTableViewController: UITableViewController, ToDoCellDelegate{
var todos = [ToDo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedToDos = ToDo.loadToDos(){
            todos = savedToDos
        }else {
            todos = ToDo.loadSampleTableViewItems()
        }
    
        

       

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
      
    }
 
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as? ToDoTableViewCell else {
            fatalError("Could not dequeue a cell")
        }
   
        
        let todo = todos[indexPath.row]
        
        cell.delegate = self
        
        cell.titleLabel.text = todo.title
        
        if   todo.isComplete == true {
            cell.isCompleteButton.setTitle(" √", for: .normal)
        }else {
            cell.isCompleteButton.setTitle("", for: .normal)
        }
        

        
        cell.toDoImage.image = todo.image
    

        return cell
    }
    
    //TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        //replace just the parts changed here not the whole array index
        
        
    }
    
    func checkmarkTapped(sender: ToDoTableViewCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            let todo = todos[indexPath.row]
            todo.isComplete = !todo.isComplete
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    //TableView Delegate: Edit
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       
        return true
    }
   

    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
//@IBActions
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue){
        guard segue.identifier == "saveUnwind" else {return}
        
        
        let addItemTableViewController = segue.source as! AddItemTableViewController
        if let todo = addItemTableViewController.todo {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                todos[selectedIndexPath.row] = todo
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }else {
                let newIndexPath = IndexPath(row: todos.count, section: 0)
                todos.append(todo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            let addItemTableViewController = segue.destination as! AddItemTableViewController
            let indexPath = tableView.indexPathForSelectedRow
            let selectedToDo = todos[(indexPath?.row)!]
            addItemTableViewController.todo = selectedToDo
        }
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
