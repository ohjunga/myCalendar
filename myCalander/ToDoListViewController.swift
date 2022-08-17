//
//  ToDoListViewController.swift
//  myCalander
//
//  Created by junga oh on 2022/08/15.
//

import UIKit

class ToDoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let cellName: String = "TodoListTableViewCell"
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        todoLabel.layer.cornerRadius = 10
        todoLabel.layer.borderWidth = 1
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    // MARK: - Table View Set
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.shared.eventStruct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //날짜순으로 정렬
        dataManager.shared.eventStruct.sort(by: {$0.event<$1.event})
        
        let customCell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! TodoListTableViewCell
        customCell.titleLabel.text = dataManager.shared.eventStruct[indexPath.row].title
        customCell.dateLabel.text = dataManager.shared.eventStruct[indexPath.row].event
        customCell.circleButton.layer.cornerRadius = customCell.circleButton.layer.frame.size.width/2
        customCell.circleButton.backgroundColor = UIColor(named: dataManager.shared.eventStruct[indexPath.row].color)
        return customCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataManager.shared.eventStruct.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveData()
        }
    }
    // MARK: - save UserDefaults
    func saveData() {
        let data = dataManager.shared.eventStruct.map {
            [
                "event" : $0.event,
                "title" : $0.title,
                "color" : $0.color,
            ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(data, forKey: "eventStruct")
    }
}
