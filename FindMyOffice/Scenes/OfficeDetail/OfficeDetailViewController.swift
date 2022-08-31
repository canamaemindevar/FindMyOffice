//
//  OfficeDetailViewController.swift
//  FindMyOffice
//
//  Created by Emincan on 6.08.2022.
//

import UIKit
import AVFoundation
import AVKit
import MapKit

protocol OfficeDetailDisplayLogic: AnyObject {
    func displayOfficeDetail(viewModel: OfficeDetail.Fetch.ViewModel)
}

let videoName = "video"

final class OfficeDetailViewController: UIViewController,ForFullScreen {
   
    
    
    @IBOutlet weak var Mapview: MKMapView!
    
    @IBOutlet weak var videoView: UIView!
  
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var roomsLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var spaceLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var interactor: OfficeDetailBusinessLogic?
    var router: (OfficeDetailRoutingLogic & OfficeDetailDataPassing)?
    
    
    var viewModel: OfficeDetail.Fetch.ViewModel?
    let layout = UICollectionViewFlowLayout()

    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @IBAction func showWebsite(_ sender: UIButton) {
        router?.routeToWebSite()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = OfficeDetailInteractor()
        let presenter = OfficeDetailPresenter()
        let router = OfficeDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    
    
    func setUpForCollection(){
        self.collectionView.register(UINib(nibName: "OfficeImagesCell", bundle: .main), forCellWithReuseIdentifier: "OfficeImagesCell")
        self.collectionView.register(UINib(nibName: "VideoCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "VideoCollectionViewCell")
        
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 15
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        let image = UIImage(systemName: "rectangle.grid.2x2.fill")
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(tapped))
        navigationItem.rightBarButtonItem = button
        
    }
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        interactor?.fetchOfficeDetail(request: OfficeDetail.Fetch.Request())
        setUpForCollection()
        Mapview.delegate = self
        setAnnotation()
        
    }
    
    
    func setAnnotation(){
        Mapview.addAnnotation(Annotation(coordinate: CLLocationCoordinate2D(latitude: viewModel?.latitude ?? 99.0, longitude: viewModel?.longitude ?? 0.0), title: viewModel?.name))

        }

// MARK: video part
    func fullScreen() {
        fullScreenForCell()
        print("geldin bura")
    }



    
  /////////////
    func fullScreenForCell(){
        guard let path = Bundle.main.path(forResource: videoName, ofType:"mp4") else {
            print("video  not found")
            return
        }
        
        pause()
        
        let playerController = AVPlayerViewController()
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
    }
}


// MARK: collectionView
extension OfficeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { // değiştir
           print(section)
           if viewModel?.images?.isVideo == true {
               return (viewModel?.images?.url?.count ?? 0) + 1 ?? 1
           }  else {
               return viewModel?.images?.url?.count  ?? 1
               
           }
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          
           if viewModel?.images?.isVideo == true && indexPath.item == 0 {
               guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as? VideoCollectionViewCell
                       // VideoCell
                       
               else {
                   return UICollectionViewCell()
               }
               cell.fullScreenDelegate = self
               return cell
           } else {
               guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfficeImagesCell", for: indexPath) as? OfficeImagesCell
                       // VideoCell
               else {
                   return UICollectionViewCell()
                   
               }
               
               if viewModel?.images?.isVideo == true {
                   cell.configure(images: viewModel?.images?.url?[indexPath.row - 1] ?? "")
                          }  else {
                              cell.configure(images: viewModel?.images?.url?[indexPath.row] ?? "")
                              
                          }
                          //cell.configure(images: model.images?.url?[indexPath.row - 1] ?? "")
                          return cell
                          
                      }
       }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToFullScreen(index: indexPath.row)
    }
    
    
    @objc func tapped(){
        if layout.scrollDirection == .horizontal {
            layout.scrollDirection = .vertical
        } else {
            layout.scrollDirection = .horizontal
        }
        collectionView.reloadData()
    }
    
    

    
    
}

extension OfficeDetailViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1) // soldan sağdan... ne kadar boşluk istiyor
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let gridLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - (gridLayout?.minimumInteritemSpacing ?? CGFloat())
        return CGSize(width: widthPerItem, height: 150)
    }
    
    
}


extension OfficeDetailViewController: OfficeDetailDisplayLogic , getIndexFromFull {
    func displayOfficeDetail(viewModel: OfficeDetail.Fetch.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.navigationItem.title = "\(viewModel.name ?? "")"
 
            self.adressLabel.text = "Adress: \(viewModel.address ?? "")"
            self.roomsLabel.text = "Rooms: \(String(describing: viewModel.rooms)) )"
            self.capacityLabel.text = "Capacity: \(viewModel.capacity ?? "")"
            self.spaceLabel.text = "Space: \(viewModel.space ?? "" )"
           self.collectionView.reloadData()
            
            
        }
    }
    
    func   fullScreenIndexPath(indexPath: IndexPath){
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    
    
}
//MARK: Mapview

extension OfficeDetailViewController:  MKMapViewDelegate{
  

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
       
        
        let location = CLLocation(latitude: viewModel?.latitude ?? 0.0,
                                  longitude: viewModel?.longitude ?? 0.0)
        CLGeocoder().reverseGeocodeLocation(location) { placemark, Error in
            if  let  placemarks = placemark  {
                let newPlacemark = MKPlacemark(placemark: placemarks[0])
                                            
                                            let item = MKMapItem(placemark: newPlacemark)
                                            
                item.name = self.viewModel?.name ?? "Not Found Offices"
                                            
                                            let launchOption = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                                            
                                            item.openInMaps(launchOptions: launchOption)
            }
        }
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
