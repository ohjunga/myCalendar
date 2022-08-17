//
//  SettingViewController.swift
//  myCalander
//
//  Created by junga oh on 2022/08/15.
//

import UIKit

class SettingViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var lockSwitchButton: UISwitch!
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        lockSwitchButton.isOn = (dataManager.shared.lockBool)
    }
    // MARK: - Tap Setting Button
    @IBAction func tapSetPasswordButton(_ sender: UIButton) {
        let storyborad = UIStoryboard.init(name: "Main", bundle: nil)
        guard let popVC = storyborad.instantiateViewController(withIdentifier: "SetPasswordViewController") as? SetPasswordViewController else {return}
        self.present(popVC, animated: true, completion: nil)
    }
    @IBAction func tapSwitchOnOff(_ sender: UISwitch) {
        if sender.isOn {
            dataManager.shared.lockBool = true
            saveData()
        } else {
            dataManager.shared.lockBool = false
            saveData()
        }
    }
    // MARK: - Save UserDefaults
    func saveData() {
        let lockStatus = dataManager.shared.lockBool
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(lockStatus, forKey: "lockStatus")
    }
}
