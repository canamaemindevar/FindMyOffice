//
//  FullScreenViewController.swift
//  FindMyOffice
//
//  Created by Emincan on 8.08.2022.
//

import UIKit
import SDWebImage

protocol FullScreenDisplayLogic: AnyObject {
    func displayPics(viewModel:FullScreen.Fetch.ViewModel)
}

final class FullScreenViewController: UIViewController {
    @IBOutlet var scrollView: UIScrollView!
    
    var interactor: FullScreenBusinessLogic?
    var router: (FullScreenRoutingLogic & FullScreenDataPassing)?
    
    var viewModel: FullScreen.Fetch.ViewModel?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      //  scrollView.frame
        interactor?.fetchOfficePics(request: OfficeDetail.Fetch.Request())
        config(viewModel: FullScreen.Fetch.ViewModel(images: viewModel?.images ?? []))
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = FullScreenInteractor()
        let presenter = FullScreenPresenter()
        let router = FullScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension FullScreenViewController: FullScreenDisplayLogic {
    func displayPics(viewModel: FullScreen.Fetch.ViewModel) {
        self.viewModel = viewModel
    }
    
    
    func config(viewModel: FullScreen.Fetch.ViewModel){
        for i in 0..<viewModel.images.count {
            let imageView = UIImageView()
            let x = self.view.frame.size.width * CGFloat(i)
            imageView.frame = CGRect(x: x, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            imageView.contentMode = .scaleAspectFit
            imageView.sd_setImage(with: URL(string: viewModel.images[i]))
                    
            scrollView.contentSize.width = scrollView.frame.size.width * CGFloat(i + 1)
            scrollView.addSubview(imageView)
        }
    }
    
    
}
