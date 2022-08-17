//
//  AddMemoViewController.swift
//  myCalander
//
//  Created by junga oh on 2022/08/15.
//

import UIKit

class AddMemoViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cancleBtn: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    var saveMemo: Array<String> = Array<String>()
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.layer.cornerRadius = 20
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
        memoManager.shared.memoStruct.append(self.textView.text!)
        saveData()
        self.presentingViewController?.dismiss(animated: true)
    }
    @IBAction func tapCancelButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true)
    }
    // MARK: - Save UserDefualts
    func saveData() {
        let array = memoManager.shared.memoStruct
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(array, forKey: "memoStruct")
    }
}
