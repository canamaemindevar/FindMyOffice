//
//  WebsiteViewController.swift
//  FindMyOffice
//
//  Created by Emincan on 19.08.2022.
//

import UIKit
import WebKit

protocol WebsiteDisplayLogic: AnyObject {
    
}

final class WebsiteViewController: UIViewController, WKNavigationDelegate {
    
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var interactor: WebsiteBusinessLogic?
    var router: (WebsiteRoutingLogic & WebsiteDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = WebsiteInteractor()
        let presenter = WebsitePresenter()
        let router = WebsiteRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        guard  let url = URL(string: "https://www.mobven.com/") else {return}
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicate(show: true)
    }
    func indicate(show: Bool) {
        if show {
            indicator.startAnimating()
        } else {
            indicator.stopAnimating()
        }
    }
    
    
    
}

extension WebsiteViewController: WebsiteDisplayLogic {
    
}
