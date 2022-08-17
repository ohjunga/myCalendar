//
//  MemoViewController.swift
//  myCalander
//
//  Created by junga oh on 2022/08/15.
//

import UIKit

class MemoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addMemoBtn: UIButton!
    
    let cellName: String = "MemoTableViewCell"
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.delegate = self
        tableView.dataSource = self
        
        /// notificationCenter observe
        NotificationCenter.default.addObserver(
                  self,
                  selector: #selector(self.didDismissDetailNotification(_:)),
                  name: NSNotification.Name("DissmissAddMemoView"),
                  object: nil
        )
        addMemoBtn.layer.cornerRadius = 10
        addMemoBtn.layer.borderWidth = 1
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    // MARK: - Add Memo
    @IBAction func addMemoBtn(_ sender: UIButton) {
        let storyborad = UIStoryboard.init(name: "Main", bundle: nil)
        guard let popVC = storyborad.instantiateViewController(withIdentifier: "AddMemoViewController") as? AddMemoViewController else {return}
        popVC.modalPresentationStyle = .overCurrentContext
        self.present(popVC, animated: true, completion: nil)
    }
    // MARK: - Table View Set
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoManager.shared.memoStruct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! MemoTableViewCell
        customCell.memoLabel.text = memoManager.shared.memoStruct[indexPath.row]
        return customCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyborad = UIStoryboard.init(name: "Main", bundle: nil)
        guard let popVC = storyborad.instantiateViewController(withIdentifier: "EditMemoViewController") as? EditMemoViewController else {return}
        popVC.editMemoIndex = indexPath.row
        popVC.modalPresentationStyle = .overCurrentContext
        self.present(popVC, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            memoManager.shared.memoStruct.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        saveData()
    }
    // MARK: - notificationCenter Observer (when add/edit view disappeared tableview reload called )
    @objc func didDismissDetailNotification(_ notification: Notification) {
          DispatchQueue.main.async {
              self.tableView.reloadData()
          }
    }
    // MARK: - Save/Load UserDefaults
    func saveData() {
        let array = memoManager.shared.memoStruct
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(array, forKey: "memoStruct")
    }
    func loadData() {
        let userDefaults = UserDefaults.standard
        guard let array = userDefaults.object(forKey: "memoStruct") as? [String] else { return }
        memoManager.shared.memoStruct = array
    }
    
}
