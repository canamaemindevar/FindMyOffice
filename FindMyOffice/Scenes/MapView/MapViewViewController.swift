//
//  MapViewViewController.swift
//  FindMyOffice
//
//  Created by Emincan on 20.08.2022.
//

import UIKit
import MapKit

protocol MapViewDisplayLogic: AnyObject {
    
}

final class MapViewViewController: UIViewController {
    
    var interactor: MapViewBusinessLogic?
    var router: (MapViewRoutingLogic & MapViewDataPassing)?
    
    @IBOutlet weak var mapView: MKMapView!
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
        mapView.delegate = self
        mapView.addAnnotation(Annotation(coordinate: .init(latitude: 40, longitude: 30), title: "Home"))
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = MapViewInteractor()
        let presenter = MapViewPresenter()
        let router = MapViewRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    
}

extension MapViewViewController: MapViewDisplayLogic {
    
}


extension MapViewViewController:MKMapViewDelegate{
    
    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
        print("mapViewWillStartLoadingMap")
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        print("mapViewDidFinishLoadingMap")
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation as? Annotation
        print("didSelect", annotation?.title ?? "")
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print("didDeselect")
    }
    
    
    class Annotation: NSObject, MKAnnotation {
            var coordinate: CLLocationCoordinate2D
            var title: String?
            
            init(coordinate: CLLocationCoordinate2D, title: String?){
                self.coordinate = coordinate
                self.title = title
            }
    }
}
