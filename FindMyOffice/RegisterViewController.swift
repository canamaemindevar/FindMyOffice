//
//  RegisterViewController.swift
//  FindMyOffice
//
//  Created by Emincan on 27.07.2022.
//

import UIKit
import Security

class RegisterViewController: UIViewController {

    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

        // Do any additional setup after loading the view.
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *){
            guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else {
                return
            }
            registerBtn.layer.borderColor = UIColor(named: "btnBorderColor")?.cgColor
            mailTextField.layer.borderColor = UIColor(named: "btnBorderColor")?.cgColor
            passwordTextField.layer.borderColor = UIColor(named: "btnBorderColor")?.cgColor
            mailTextField.attributedPlaceholder = NSAttributedString(
                string: "Mail",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Color")!])
            passwordTextField.attributedPlaceholder = NSAttributedString(
                string: "Password",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Color")!])
        }
    }
    

    private func updateUI(){
        registerBtn.backgroundColor = UIColor(named: "background")
        registerBtn.layer.cornerRadius = 5
        registerBtn.layer.borderWidth = 1
        registerBtn.layer.borderColor = UIColor(named: "btnBorderColor")?.cgColor
        
        
        mailTextField.backgroundColor = UIColor(named: "background")
        mailTextField.layer.borderWidth = 1
        mailTextField.layer.cornerRadius = 5
        mailTextField.layer.borderColor = UIColor(named: "btnBorderColor")?.cgColor
        mailTextField.attributedPlaceholder = NSAttributedString(
            string: "Mail",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        passwordTextField.backgroundColor = UIColor(named: "background")
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.layer.borderColor = UIColor(named: "btnBorderColor")?.cgColor
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }

    @IBAction func btnPressed(_ sender: UIButton) {
        do {
            try  KeyChainManager().saveToChain(mail: mailTextField.text!, password: (passwordTextField.text?.data(using: .utf8))!)
        } catch  {
            print(error)
        }
        
    }
    
    
    
}

extension RegisterViewController {
    
}


class KeyChainManager {
    
    enum KeyChainError: Error{
        case duplicateEntry
        case unknown(OSStatus)
    }
    
    func saveToChain(mail:String,password:Data)
        throws {
            let query: [String:AnyObject] = [kSecAttrAccount as String: mail as AnyObject,
                                             kSecValueData as String: password as AnyObject,
                                             kSecClass as String: kSecClassGenericPassword
            ]
            let status = SecItemAdd(query as CFDictionary, nil )
            guard status != errSecDuplicateItem else{
                throw KeyChainError.duplicateEntry
            }
            guard status == errSecSuccess else {
                throw  KeyChainError.unknown(status)
            }
            print("saved")
        }

    
    func getFromChain(mail:String)
         -> Data? {
            let query: [String:AnyObject] = [kSecAttrAccount as String: mail as AnyObject,
                                             kSecReturnData as String: kCFBooleanTrue,
                                             kSecClass as String: kSecClassGenericPassword,
                                             kSecMatchLimit as String: kSecMatchLimitOne
            ]
            var result: AnyObject?
            let status = SecItemCopyMatching(query as CFDictionary, &result)
           
            print("Read Status \(status)")
            return result as? Data
        }
    
    

}

