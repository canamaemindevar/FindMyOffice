//
//  ViewController.swift
//  FindMyOffice
//
//  Created by Emincan on 4.07.2022.
//

import UIKit
import CoreData
import Security

class LoginViewController: UIViewController {

    @IBOutlet weak var mailTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
//      let mainUrl = Bundle.main.infoDictionary?["BACKEND_URL"] as? String
        let ShowVersion = (Bundle.main.infoDictionary?["SHOW_VERSION"] as? String) == "YES"
        if ShowVersion {
            // Todo: show version label
        } else {
            // hide
        }
        mailTextfield.delegate = self

        print(ShowVersion)
    }

    @IBAction func btnPressed(_ sender: UIButton) {
        goToPageController()
        
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *){
            guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else {
                return
            }
            loginBtn.layer.borderColor = UIColor(named: "btnBorderColor")?.cgColor
            mailTextfield.layer.borderColor = UIColor(named: "btnBorderColor")?.cgColor
            passwordTextField.layer.borderColor = UIColor(named: "btnBorderColor")?.cgColor
            mailTextfield.attributedPlaceholder = NSAttributedString(
                string: "Mail",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Color")!])
            passwordTextField.attributedPlaceholder = NSAttributedString(
                string: "Password",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Color")!])
        }
    }
    
    private func updateUI(){
        loginBtn.backgroundColor = UIColor(named: "background")
        loginBtn.layer.cornerRadius = 5
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.borderColor = UIColor(named: "btnBorderColor")?.cgColor
        
        mailTextfield.backgroundColor = UIColor(named: "background")
        mailTextfield.layer.borderWidth = 1
        mailTextfield.layer.cornerRadius = 5
        mailTextfield.layer.borderColor = UIColor(named: "btnBorderColor")?.cgColor
        mailTextfield.attributedPlaceholder = NSAttributedString(
            string: "Mail",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Color")!])
        
        passwordTextField.backgroundColor = UIColor(named: "background")
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.layer.borderColor = UIColor(named: "btnBorderColor")?.cgColor
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Color")!])
    }
    
    
    
    
    weak var viewController: LoginViewController?
    
    func goToPageController(){
        self.navigationController?.pushViewController(PageViewController(), animated: true)
    }

}
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let result = KeyChainManager().getFromChain(mail: mailTextfield.text!) else {
            print("Failed to read password")
            return
        }
        let password = String(decoding:result,as: UTF8.self )
        print(password)
        passwordTextField.text = password
        
    }
    
    
}





