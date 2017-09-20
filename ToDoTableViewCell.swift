//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by anthony on 7/8/17.
//  Copyright © 2017 Casandra Hayward. All rights reserved.
//

import UIKit
@objc protocol ToDoCellDelegate: class {
    func checkmarkTapped(sender: ToDoTableViewCell)
}
class ToDoTableViewCell: UITableViewCell {

    var delegate: ToDoCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isCompleteButton: UIButton!
    //@IBOutlet weak var dueDateLabel: UILabel!
    //@IBOutlet weak var notesTextField: UITextField!
    
    @IBOutlet weak var toDoImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func completedButtonTapped() {
        delegate?.checkmarkTapped(sender: self)
    }

}
