//
//  LockViewController.swift
//  myCalander
//
//  Created by junga oh on 2022/08/16.
//

import UIKit

class LockViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var passwordLabel: UILabel!
    
    var comparePassword: Array<String> = Array<String>()
    var tapCount: Int = 0

    @IBOutlet weak var buttonNum1: UIButton!
    @IBOutlet weak var buttonNum2: UIButton!
    @IBOutlet weak var buttonNum3: UIButton!
    @IBOutlet weak var buttonNum4: UIButton!
    
    @IBOutlet weak var buttonNumber1: UIButton!
    @IBOutlet weak var buttonNumber2: UIButton!
    @IBOutlet weak var buttonNumber3: UIButton!
    @IBOutlet weak var buttonNumber4: UIButton!
    @IBOutlet weak var buttonNumber5: UIButton!
    @IBOutlet weak var buttonNumber6: UIButton!
    @IBOutlet weak var buttonNumber7: UIButton!
    @IBOutlet weak var buttonNumber8: UIButton!
    @IBOutlet weak var buttonNumber9: UIButton!
    @IBOutlet weak var buttonNumberStar: UIButton!
    @IBOutlet weak var buttonNumber0: UIButton!
    @IBOutlet weak var buttonNumberHash: UIButton!
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Tap number button
    @IBAction func tapNumberButton(_ sender: UIButton) {
        tapCount = tapCount + 1
        
        switch sender {
        case buttonNumber0: comparePassword.append("0"); break
        case buttonNumber1: comparePassword.append("1"); break
        case buttonNumber2: comparePassword.append("2"); break
        case buttonNumber3: comparePassword.append("3"); break
        case buttonNumber4: comparePassword.append("4"); break
        case buttonNumber5: comparePassword.append("5"); break
        case buttonNumber6: comparePassword.append("6"); break
        case buttonNumber7: comparePassword.append("7"); break
        case buttonNumber8: comparePassword.append("8"); break
        case buttonNumber9: comparePassword.append("9"); break
        case buttonNumberStar: comparePassword.append("*"); break
        case buttonNumberHash: comparePassword.append("#"); break
        default: break
        }
        switch tapCount {
        case 1: buttonNum1.setTitle("*", for: .normal); break
        case 2: buttonNum2.setTitle("*", for: .normal); break
        case 3: buttonNum3.setTitle("*", for: .normal); break
        case 4:
            buttonNum4.setTitle("*", for: .normal)
            if comparePassword == dataManager.shared.password {
                comparePassword.removeAll()
                dataManager.shared.localLockStatus = false
                self.presentingViewController?.dismiss(animated: true)
            } else {
                
                buttonNum1.setTitle("-", for: .normal)
                buttonNum2.setTitle("-", for: .normal)
                buttonNum3.setTitle("-", for: .normal)
                buttonNum4.setTitle("-", for: .normal)
                passwordLabel.text = "다시 시도해주세요 !"
                comparePassword.removeAll()
                tapCount = 0
            }
        default: break
        }
    }
}
