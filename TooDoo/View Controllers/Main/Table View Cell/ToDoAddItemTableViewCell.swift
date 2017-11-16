//
//  ToDoAddItemTableViewCell.swift
//  TooDoo
//
//  Created by Cali Castle  on 11/16/17.
//  Copyright © 2017 Cali Castle . All rights reserved.
//

import UIKit
import CoreData

protocol ToDoAddItemTableViewCellDelegate {
    
    func newTodoBeganEditing()
    func newTodoDoneEditing(todo: ToDo)
    
}

class ToDoAddItemTableViewCell: UITableViewCell {
    
    /// Reuse identifier.
    
    static let identifier = "ToDoAddItemTableCell"
    
    override var reuseIdentifier: String? {
        return type(of: self).identifier
    }
    
    /// Managed Object Context.
    
    var managedObjectContext: NSManagedObjectContext?
    
    /// Stored primary color.
    
    var primaryColor: UIColor = .clear {
        didSet {
            let color = UIColor(contrastingBlackOrWhiteColorOn: UIColor(contrastingBlackOrWhiteColorOn: primaryColor, isFlat: true),
                                isFlat: true).lighten(byPercentage: 0.1)
            
            // Configure text field color
            goalTextField.textColor = color
            goalTextField.text = ""
            goalTextField.keyboardAppearance = UIColor(contrastingBlackOrWhiteColorOn: primaryColor, isFlat: false).hexValue() == UIColor.white.hexValue() ? .light : .dark
            goalTextField.tintColor = color?.lighten(byPercentage: 0.15)
            
            // Configure edit button color
            editButton.tintColor = color?.withAlphaComponent(0.25)
        }
    }
    
    var delegate: ToDoAddItemTableViewCellDelegate?
    
    // MARK: - Interface Builder Outlets.
    
    @IBOutlet var goalTextField: UITextField!
    @IBOutlet var editButton: UIButton!
    
    /// When the goal started editing.
    
    @IBAction func goalBeganEditing(_ sender: UITextField) {
        guard let delegate = delegate else { return }
        
        delegate.newTodoBeganEditing()
    }
    
    /// When the goal is finished editing.
    
    @IBAction func goalDoneEditing(_ sender: UITextField) {
        guard let delegate = delegate, validateUserInput(text: sender.text!) else { return }
        
        sender.resignFirstResponder()
        
        let todo = ToDo(context: managedObjectContext!)
        let goal = (sender.text?.trimmingCharacters(in: .whitespaces))!
        
        todo.goal = goal
        todo.createdAt = Date()
        
        delegate.newTodoDoneEditing(todo: todo)
    }
    
    private func validateUserInput(text: String) -> Bool {
        return text.trimmingCharacters(in: .whitespaces).count != 0
    }
    
}