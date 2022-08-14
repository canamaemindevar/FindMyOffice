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
    var interactor: (OfficesBusinessLogic & GetFilteredData)?
    var router: (OfficesRoutingLogic & OfficesDataPassing)?
    var viewModel: Offices.Fetch.ViewModel?
    var pickerView = UIPickerView()
    
    var options = [Options]()
    
    @IBOutlet weak var filterTextField: UITextField!
    
    
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
        pickerView.dataSource = self
        pickerView.delegate = self
        
        setupOptions()
        filterTextField.inputView = pickerView
        createToolBarForPickerView()
    }
    
    func createToolBarForPickerView(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.isUserInteractionEnabled = true
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dissmisButton))
        
        toolBar.setItems([doneButton], animated: false)
        
        filterTextField.inputAccessoryView = toolBar
    }
    
    @objc func dissmisButton() {
        view.endEditing(true)
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
    
    private func setupOptions(){
        let capacityOptions: Options = .init(options: "Capacity", values: ["0-5","5-10","10-15","15-20"])
        let roomsOptions: Options = .init(options: "Rooms", values: ["2","4","5","8","10","12"])
        let spaceOptions: Options = .init(options: "Space", values: ["75","100","101","125","165","250"])
        options.append(capacityOptions)
        options.append(roomsOptions)
        options.append(spaceOptions)
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
// MARK: tableView
extension OfficesViewController: UITableViewDelegate, UITableViewDataSource {
   
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as? OfficeListCell else { return UITableViewCell()}
        
        guard let model = viewModel?.offices[indexPath.row]  else {
            return UITableViewCell()
        }
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = UIColor(named: "btnBorderColor")?.cgColor
        cell.configure(viewModel: model)
        

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.offices.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToOfficeDetail(index: indexPath.row)
    }
 
    
}



extension OfficesViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return options.count
        }
        else {
            return options[pickerView.selectedRow(inComponent: 0)].values.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return options[row].options
        } else {
            let selectedData = pickerView.selectedRow(inComponent: 0)
         
            return options[selectedData].values[row]
            
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadComponent(1)
        let selectedData = pickerView.selectedRow(inComponent: 0)
        let selectItem = options[selectedData].values[row]
        filterTextField.text = selectItem
        interactor?.filterRequest(request: selectItem ?? "")
        
        
        
    }
    
    
    
    
}


/*
 func toolbarSetup(){
     let toolBar = UIToolbar()
     toolBar.sizeToFit()
     toolBar.isUserInteractionEnabled = true
     let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(closePickerView))
     filterTextField.inputAccessoryView = toolBar
     toolBar.setItems([doneButton], animated: true)
 
 }
 @objc func closePickerView() {
     view.endEditing(true)
     print("eeee")
}
 */
