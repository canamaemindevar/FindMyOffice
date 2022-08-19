//
//  fullScreenCell.swift
//  FindMyOffice
//
//  Created by Emincan on 10.08.2022.
//

import UIKit
import SDWebImage

class fullScreenCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config(images: String?){
        imageView.sd_setImage(with: URL(string: images ?? ""))
    }
    
}
