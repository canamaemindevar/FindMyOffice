//
//  ViewController.swift
//  FindMyOffice
//
//  Created by Emincan on 4.07.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//      let mainUrl = Bundle.main.infoDictionary?["BACKEND_URL"] as? String
        let ShowVersion = (Bundle.main.infoDictionary?["SHOW_VERSION"] as? String) == "YES"
        if ShowVersion {
            // Todo: show version label
        } else {
            // hide
        }
        
        
        print(ShowVersion)
    }


}

