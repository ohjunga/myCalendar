//
//  AddTaskViewController.swift
//  myCalander
//
//  Created by junga oh on 2022/08/15.
//

import UIKit

protocol SendDataDelegate: AnyObject {
    func sendTitle(str: String, color: String)
}

class AddTaskViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var buttonCancle: UIButton!
    
    @IBOutlet weak var toDoTextField: UITextField!
    
    @IBOutlet weak var button1Color: UIButton!
    @IBOutlet weak var button2Color: UIButton!
    @IBOutlet weak var button3Color: UIButton!
    @IBOutlet weak var button4Color: UIButton!
    @IBOutlet weak var button5Color: UIButton!
    
    @IBOutlet weak var addTaskView: UIView!
    
    weak var delegate: SendDataDelegate?
    
    var selectColor: String = "Bee"
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSet()
    }
    // MARK: View UI Set
    func viewSet() {
        self.addTaskView.layer.cornerRadius = 20
        self.addTaskView.layer.borderColor = UIColor.lightGray.cgColor
        self.addTaskView.layer.borderWidth = 1
        
        toDoTextField.becomeFirstResponder()
        
        button1Color.layer.cornerRadius = button1Color.layer.frame.size.width/2
        button1Color.backgroundColor = UIColor(named: "Bee")
        button2Color.layer.cornerRadius = button2Color.layer.frame.size.width/2
        button2Color.backgroundColor = UIColor(named: "Honey")
        button3Color.layer.cornerRadius = button3Color.layer.frame.size.width/2
        button3Color.backgroundColor = UIColor(named: "Flutter")
        button4Color.layer.cornerRadius = button4Color.layer.frame.size.width/2
        button4Color.backgroundColor = UIColor(named: "Redish")
        button5Color.layer.cornerRadius = button5Color.layer.frame.size.width/2
        button5Color.backgroundColor = UIColor(named: "Striped")
    }
    // MARK: hide keyboard when touch view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    // MARK: - Save/Cancel Event
    @IBAction func tapCancleBtn(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true)
    }
    @IBAction func tapSaveBtn(_ sender: UIButton) {
        self.delegate?.sendTitle(str: toDoTextField.text!, color: selectColor)
        self.presentingViewController?.dismiss(animated: true)
    }
    @IBAction func tapEventColor(_ sender: UIButton) {
        switch (sender) {
        case button1Color : selectColor = "Bee"
        case button2Color: selectColor = "Honey"
        case button3Color: selectColor = "Flutter"
        case button4Color: selectColor = "Redish"
        case button5Color: selectColor = "Striped"
        default:
            selectColor = "Bee"
        }
    }
    
}
