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
    var progressView: UIProgressView!
    var interactor: WebsiteBusinessLogic?
    var router: (WebsiteRoutingLogic & WebsiteDataPassing)?
    var websites = ["www.mobven.com"]
    
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
        webView.allowsBackForwardNavigationGestures = true
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .done, target: webView, action: #selector(webView.goBack))
        let forwardButton = UIBarButtonItem(image: UIImage(systemName: "arrow.forward"), style: .done, target: webView, action: #selector(webView.goForward))

        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressItem = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [backButton,forwardButton,spacer,progressItem,spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress),options: .new, context: nil)
        
    }
    
    override  func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicate(show: true)
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicate(show: false)
        title = webView.title
    }
    
    func indicate(show: Bool) {
        if show {
            indicator.startAnimating()
        } else {
            indicator.stopAnimating()
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        if let host = url?.host {
            for website in websites{
                if host.contains(website){
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
    }
    
    
    
}

extension WebsiteViewController: WebsiteDisplayLogic {
    
}
