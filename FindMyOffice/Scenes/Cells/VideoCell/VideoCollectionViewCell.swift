//
//  VideoCollectionViewCell.swift
//  FindMyOffice
//
//  Created by Emincan on 26.08.2022.
//

import UIKit
import AVKit
import AVFoundation

class VideoCollectionViewCell: UICollectionViewCell {
 
    var myPlayer: AVPlayer!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var fullScreenButtonOutlet: UIButton!
    @IBOutlet weak var playButtonOutlet: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureVideoPlayer() {
        guard let path = Bundle.main.path(forResource: videoName, ofType:"mp4") else {
            print("video  not found")
            return
        }
        myPlayer = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: myPlayer)
        playerLayer.frame = videoView.bounds
        videoView.layer.addSublayer(playerLayer)
        videoView.addSubview(playButtonOutlet)
        videoView.addSubview(fullScreenButtonOutlet)
    }
    
    func fullScreenPlay(){
     
    
    
    
    }
    @IBAction func playButton(_ sender: UIButton) {
    }
    @IBAction func fullScreenButton(_ sender: UIButton) {
    }

}
