//
//  SetPasswordViewController.swift
//  myCalander
//
//  Created by junga oh on 2022/08/16.
//

import UIKit

class SetPasswordViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordButton1: UIButton!
    @IBOutlet weak var passwordButton2: UIButton!
    @IBOutlet weak var passwordButton3: UIButton!
    @IBOutlet weak var passwordButton4: UIButton!
    
    var confirmPassword: Array<String> = Array<String>()
    
    var count: Int = 0
    
    @IBOutlet weak var buttonNum1: UIButton!
    @IBOutlet weak var buttonNum2: UIButton!
    @IBOutlet weak var buttonNum3: UIButton!
    @IBOutlet weak var buttonNum4: UIButton!
    @IBOutlet weak var buttonNum5: UIButton!
    @IBOutlet weak var buttonNum6: UIButton!
    @IBOutlet weak var buttonNum7: UIButton!
    @IBOutlet weak var buttonNum8: UIButton!
    @IBOutlet weak var buttonNum9: UIButton!
    @IBOutlet weak var buttonNumStar: UIButton!
    @IBOutlet weak var buttonNum0: UIButton!
    @IBOutlet weak var buttonNumHash: UIButton!
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.shared.password.removeAll()
        count = 0
        passwordButton1.setTitle("-", for: .normal)
        passwordButton2.setTitle("-", for: .normal)
        passwordButton3.setTitle("-", for: .normal)
        passwordButton4.setTitle("-", for: .normal)
    }
    // MARK: - Tap Number Button
    @IBAction func tapNumberButton(_ sender: UIButton) {
        count = count + 1
        switch count {
        case 1: passwordButton1.setTitle("*", for: .normal); break
        case 2: passwordButton2.setTitle("*", for: .normal); break
        case 3: passwordButton3.setTitle("*", for: .normal); break
        case 4:
            passwordButton4.setTitle("*", for: .normal)
            passwordButton1.setTitle("-", for: .normal)
            passwordButton2.setTitle("-", for: .normal)
            passwordButton3.setTitle("-", for: .normal)
            passwordButton4.setTitle("-", for: .normal)
            break
        case 5: passwordButton1.setTitle("*", for: .normal); break
        case 6: passwordButton2.setTitle("*", for: .normal); break
        case 7: passwordButton3.setTitle("*", for: .normal); break
        case 8: passwordButton4.setTitle("*", for: .normal); break
        default: break
        }
        
        if dataManager.shared.password.count >= 4 {
            passwordLabel.text = "다시 한번 입력해주세요."
            switch sender {
            case buttonNum0: confirmPassword.append("0"); break
            case buttonNum1: confirmPassword.append("1"); break
            case buttonNum2: confirmPassword.append("2"); break
            case buttonNum3: confirmPassword.append("3"); break
            case buttonNum4: confirmPassword.append("4"); break
            case buttonNum5: confirmPassword.append("5"); break
            case buttonNum6: confirmPassword.append("6"); break
            case buttonNum7: confirmPassword.append("7"); break
            case buttonNum8: confirmPassword.append("8"); break
            case buttonNum9: confirmPassword.append("9"); break
            case buttonNumStar: confirmPassword.append("*"); break
            case buttonNumHash: confirmPassword.append("#"); break
            default: break
            }
            if confirmPassword.count >= 4 {
                if confirmPassword == dataManager.shared.password {
                    self.presentingViewController?.dismiss(animated: true)
                    print("비밀번호 설정완료")
                    saveData()
                } else {
                    passwordLabel.text = "비밀번호가 일치하지 않습니다."
                    dataManager.shared.password.removeAll()
                    confirmPassword.removeAll()
                    passwordButton1.setTitle("-", for: .normal)
                    passwordButton2.setTitle("-", for: .normal)
                    passwordButton3.setTitle("-", for: .normal)
                    passwordButton4.setTitle("-", for: .normal)
                    count = 0
                }
            }
        } else if dataManager.shared.password.count < 4 {
            switch sender {
            case buttonNum0: dataManager.shared.password.append("0"); break
            case buttonNum1: dataManager.shared.password.append("1"); break
            case buttonNum2: dataManager.shared.password.append("2"); break
            case buttonNum3: dataManager.shared.password.append("3"); break
            case buttonNum4: dataManager.shared.password.append("4"); break
            case buttonNum5: dataManager.shared.password.append("5"); break
            case buttonNum6: dataManager.shared.password.append("6"); break
            case buttonNum7: dataManager.shared.password.append("7"); break
            case buttonNum8: dataManager.shared.password.append("8"); break
            case buttonNum9: dataManager.shared.password.append("9"); break
            case buttonNumStar: dataManager.shared.password.append("*"); break
            case buttonNumHash: dataManager.shared.password.append("#"); break
            default: break
            }
        }
    }
    // MARK: Tap Cancel Button
    @IBAction func tapCancelButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true)
    }
    // MARK: - save UserDefualts
    func saveData() {
        let password = dataManager.shared.password
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(password, forKey: "password")
    }
}
