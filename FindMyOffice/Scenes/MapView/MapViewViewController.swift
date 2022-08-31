//
//  MapViewViewController.swift
//  FindMyOffice
//
//  Created by Emincan on 20.08.2022.
//

import UIKit
import MapKit

protocol MapViewDisplayLogic: AnyObject {
    func displayOfficeLocation(viewModels:Offices.Fetch.ViewModel)
}

final class MapViewViewController: UIViewController {
    
    var viewModel: Offices.Fetch.ViewModel?
    
    var interactor: MapViewBusinessLogic?{didSet {
        interactor?.fetchOffices(request: Offices.Fetch.Request())
    }}
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
        setAnnotation()
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
    func setAnnotation(){
        viewModel?.offices.forEach { officeLocation in
            mapView.addAnnotation(Annotation(coordinate: .init(latitude: officeLocation.location?.latitude ?? 0.0, longitude: officeLocation.location?.longitude ?? 0.0), title: officeLocation.name))
        }
    }
}

extension MapViewViewController: MapViewDisplayLogic {
    func displayOfficeLocation(viewModels: Offices.Fetch.ViewModel) {
        self.viewModel = viewModels
    }
}


//MARK: Mapview Config + navigate to apple maps
extension MapViewViewController {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil // hides user location
        }
        
        let reuseId = "myAnnotation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier:reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            pinView?.tintColor = .gray
            
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        }
        else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let choosenAnnotation = view.annotation else {return}
        
        let location = CLLocation(latitude: choosenAnnotation.coordinate.latitude,
                                                     longitude: choosenAnnotation.coordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { placemark, Error in
            if  let  placemarks = placemark  {
                let newPlacemark = MKPlacemark(placemark: placemarks[0])
                                            
                                            let item = MKMapItem(placemark: newPlacemark)
                                            
                                            item.name = choosenAnnotation.title ?? "Not Found Offices"
                                            
                                            let launchOption = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                                            
                                            item.openInMaps(launchOptions: launchOption)
            }
        }
    }
}

//MARK: Mapview Delegate + Class

extension MapViewViewController:MKMapViewDelegate{
    
//    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
//        print("mapViewWillStartLoadingMap")
//    }
//
//    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
//        print("mapViewDidFinishLoadingMap")
//    }
//
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        let annotation = view.annotation as? Annotation
//        print("didSelect", annotation?.title ?? "")
//    }
//
//    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
//        print("didDeselect")
//    }
    
    
    class Annotation: NSObject, MKAnnotation {
            var coordinate: CLLocationCoordinate2D
            var title: String?
            
            init(coordinate: CLLocationCoordinate2D, title: String?){
                self.coordinate = coordinate
                self.title = title
            }
    }
}


