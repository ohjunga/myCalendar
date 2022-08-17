//
//  EditMemoViewController.swift
//  myCalander
//
//  Created by junga oh on 2022/08/16.
//

import UIKit

class EditMemoViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var textView: UITextView!
    var editMemoIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.layer.cornerRadius = 20
        self.textView.text! = memoManager.shared.memoStruct[editMemoIndex!]
        self.textView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        textView.becomeFirstResponder()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.post(name: NSNotification.Name("DissmissAddMemoView"), object: nil, userInfo: nil)
    }
    // MARK: - hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    // MARK: - Save/Cancel Memo
    @IBAction func tapSaveButton(_ sender: UIButton) {
        memoManager.shared.memoStruct[editMemoIndex!] = self.textView.text!
        saveData()
        self.presentingViewController?.dismiss(animated: true)
    }
    @IBAction func tapCancelButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true)
    }
    // MARK: - Save UserDefaults
    func saveData() {
        let array = memoManager.shared.memoStruct
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(array, forKey: "memoStruct")
    }
}
