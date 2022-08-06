//
//  OfficesViewController.swift
//  FindMyOffice
//
//  Created by Emincan on 4.08.2022.
//

import UIKit

protocol OfficesDisplayLogic: AnyObject {
    func displayOffice(viewModel:Offices.Fetch.ViewModel)
}

final class OfficesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var interactor: OfficesBusinessLogic?
    var router: (OfficesRoutingLogic & OfficesDataPassing)?
    var viewModel: Offices.Fetch.ViewModel?
    
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
        interactor?.fetchOffices(request: Offices.Fetch.Request())
        tableView.register(UINib(nibName: "OfficeListCell", bundle: nil), forCellReuseIdentifier: "MyCell")
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = OfficesInteractor()
        let presenter = OfficesPresenter()
        let router = OfficesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension OfficesViewController: OfficesDisplayLogic {
    func displayOffice(viewModel: Offices.Fetch.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        print(viewModel.offices)
    }
    
    
}
extension OfficesViewController: UITableViewDelegate, UITableViewDataSource {
   
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as? OfficeListCell else { return UITableViewCell()}
        
        guard let model = viewModel?.offices[indexPath.row]  else {
            return UITableViewCell()
        }
        
            cell.configure(viewModel: model)

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.offices.count ?? 1
    }
    
 
    
}
