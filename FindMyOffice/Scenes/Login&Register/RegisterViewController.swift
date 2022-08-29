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






