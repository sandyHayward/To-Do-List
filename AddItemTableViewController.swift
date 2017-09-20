//
//  AddItemTableViewController.swift
//  ToDoList
//
//  Created by anthony on 7/9/17.
//  Copyright © 2017 Casandra Hayward. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Outlets
   
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var isCompleteSwitch: UISwitch!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTexfield: UITextField!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var addPhotoImage : UIImageView!
    
    //Pass data model object
    var todo: ToDo?
    
    
    //Instance Variables
    var isDatePickerHidden = true
    
    
    
    
    //View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todo = todo {
            navigationItem.title = "To - Do"
            titleTextfield.text = todo.title
            isCompleteSwitch.isOn = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTexfield.text = todo.notes
            
        }else {
            dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
        

        }
        //saveBarButton.isEnabled = false
        updateSaveButtonState()
        updateDueDateLabel(date: dueDatePickerView.date)
            }
    
    //ACTIONS AND METHODS
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
//SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let title = titleTextfield.text!
        let isComplete = isCompleteSwitch.isOn
        let dueDate = dueDatePickerView.date
        let notes = notesTexfield.text
        guard let image = addPhotoImage.image else {return}
        todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate , notes: notes , image: image)
        
        
    }
    
    
    //CONFIGURE TABLE VIEW INTERFACE ELEMENTS 
    
    //Save Bar Button Item
        func updateSaveButtonState(){
        if todo != nil {
            saveBarButton.isEnabled = true
        }
    }
    
    //TextField
    
    //Due Date Label
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
        
    }
    //When user changes the date picker (the Primary Action) Triggers the datePickerChanged action
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePickerView.date)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        
        switch (indexPath) {
        case [3,0]: return isDatePickerHidden ? normalCellHeight: largeCellHeight
        case [4,0]: return largeCellHeight
        default: return normalCellHeight
        }
    }
    
    //when tap on cell toggles isDueDatePickerHidden
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        switch (indexPath){
        case [3,0]: isDatePickerHidden = !isDatePickerHidden
        dueDateLabel.textColor = isDatePickerHidden ? .black: tableView.tintColor
        tableView.beginUpdates()
        tableView.endUpdates()
        default: break
            
    }
        
}
    
    
    
    //Add Photo Button
    //Image Picker
    
    @IBAction func selectAPhoto(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Select Photo", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)})
            alertController.addAction(photoLibraryAction)
        }
        
        alertController.popoverPresentationController?.sourceView = sender
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            addPhotoImage.image = selectedImage
            
            dismiss(animated: true, completion: nil)
          
               }
        print("image selected")
    }
    @IBAction func test() {
        print("in test")
        guard let image = addPhotoImage.image else {print("no image")
            return}
        guard let title = titleTextfield.text else {print("no title")
            return}
        
      todo = ToDo(title: title, isComplete: isCompleteSwitch.isOn, dueDate: dueDatePickerView.date, notes: notesTexfield.text, image: image)
        print(todo?.title)
        print(todo?.isComplete)
        print(todo?.dueDate)
        print(todo?.notes)
        print(todo?.image)
        
    }

    
    
}
