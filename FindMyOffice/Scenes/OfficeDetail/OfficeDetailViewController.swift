//
//  OfficeDetailViewController.swift
//  FindMyOffice
//
//  Created by Emincan on 6.08.2022.
//

import UIKit
import AVFoundation
import AVKit

protocol OfficeDetailDisplayLogic: AnyObject {
    func displayOfficeDetail(viewModel: OfficeDetail.Fetch.ViewModel)
}

let videoName = "video"

final class OfficeDetailViewController: UIViewController,ForFullScreen {
   
    
    
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var roomsLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var spaceLabel: UILabel!
    @IBOutlet weak var playButtonOutlet: UIButton!
    @IBOutlet weak var fullScreenOutlet: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var interactor: OfficeDetailBusinessLogic?
    var router: (OfficeDetailRoutingLogic & OfficeDetailDataPassing)?
    
    
    var viewModel: OfficeDetail.Fetch.ViewModel?
    let layout = UICollectionViewFlowLayout()
  //  var myPlayer: AVPlayer!
    
//    @IBAction func fullScreen(_ sender: UIButton) {
//        fullScreenPlay()
//    }
    
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
      //  fullScreenDelegate = self
        setUpForCollection()
     //   configureVideoPlayer()
        videoView.isHidden = true
    }
    
    


// MARK: video part
    func fullScreen() {
        fullScreenForCell()
        print("geldin bura")
    }


//    func configureVideoPlayer() {
//        guard let path = Bundle.main.path(forResource: videoName, ofType:"mp4") else {
//            print("video  not found")
//            return
//        }
//        myPlayer = AVPlayer(url: URL(fileURLWithPath: path))
//        let playerLayer = AVPlayerLayer(player: myPlayer)
//        playerLayer.frame = videoView.bounds
//        playerLayer.videoGravity = .resizeAspect
//        videoView.layer.addSublayer(playerLayer)
//        videoView.addSubview(playButtonOutlet)
//        videoView.addSubview(fullScreenOutlet)
//        playButtonOutlet.setImage(UIImage(systemName: "play"), for: .normal)
//        fullScreenOutlet.setImage(UIImage(systemName: "command"), for: .normal)
//    }
//
//    func fullScreenPlay(){
//        guard let path = Bundle.main.path(forResource: videoName, ofType:"mp4") else {
//            print("video  not found")
//            return
//        }
//
//        pause()
//
//        let playerController = AVPlayerViewController()
//        let player = AVPlayer(url: URL(fileURLWithPath: path))
//        playerController.player = player
//        present(playerController, animated: true) {
//            player.play()
//        }
//    }
//    @IBAction func playButton(_ sender: UIButton) {
//       playPause()
//
//    }
//    func playPause() {
//        switch myPlayer.timeControlStatus {
//        case .playing:
//            pause()
//        case .paused:
//           play()
//        default:
//            break
//        }
//    }
//    private func play() {
//        myPlayer.play()
//        playButtonOutlet.setImage(UIImage(systemName: "pause"), for: .normal)
//    }
//
//    private func pause() {
//        myPlayer.pause()
//        playButtonOutlet.setImage(UIImage(systemName: "play"), for: .normal)
//    }
    
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
//extension OfficeDetailViewController: ForFullScreen{
//    func fullScreen() {
//        fullScreenForCell()
//    }
//
//
//
//}
