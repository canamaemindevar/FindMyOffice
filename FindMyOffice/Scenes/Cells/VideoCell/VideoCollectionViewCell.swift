//
//  VideoCollectionViewCell.swift
//  FindMyOffice
//
//  Created by Emincan on 26.08.2022.
//

import UIKit
import AVKit
import AVFoundation

protocol ForFullScreen{
    func fullScreen()
}

class VideoCollectionViewCell: UICollectionViewCell{
 
    var fullScreenDelegate: ForFullScreen?
    var mySecondPlayer: AVPlayer!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var fullScreenButtonOutlet: UIButton!
    @IBOutlet weak var playButtonOutlet: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureVideoPlayer()
        
        
    }

    func configureVideoPlayer() {
        guard let path = Bundle.main.path(forResource: videoName, ofType:"mp4") else {
            print("video  not found")
            return
        }
        mySecondPlayer = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: mySecondPlayer)
        playerLayer.frame = videoView.bounds
        videoView.layer.addSublayer(playerLayer)
        videoView.addSubview(playButtonOutlet)
        videoView.addSubview(fullScreenButtonOutlet)
        playButtonOutlet.setImage(UIImage(systemName: "play"), for: .normal)
        fullScreenButtonOutlet.setImage(UIImage(systemName: "command"), for: .normal)
    }
    
    func fullScreenPlay(){
     
        guard let path = Bundle.main.path(forResource: videoName, ofType:"mp4") else {
            print("video  not found")
            return
        }
        
        pause()
        
        let playerController = AVPlayerViewController()
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        playerController.player = player
//        present(playerController, animated: true) {
//            player.play()
//        }
    
    
    }
    
    private func play() {
        mySecondPlayer.play()
        playButtonOutlet.setImage(UIImage(systemName: "pause"), for: .normal)
    }
    
    private func pause() {
        mySecondPlayer.pause()
        playButtonOutlet.setImage(UIImage(systemName: "play"), for: .normal)
    }
    
    func playPause() {
        switch mySecondPlayer.timeControlStatus {
        case .playing:
            pause()
        case .paused:
           play()
        default:
            break
        }
    }
    
    
    
    @IBAction func playButton(_ sender: UIButton) {
        playPause()
    }
    @IBAction func fullScreenButton(_ sender: UIButton) {
      //  fullScreenPlay()
        pause()
        fullScreenDelegate?.fullScreen()
    }

}
