//
//  OfficeImagesCell.swift
//  FindMyOffice
//
//  Created by Emincan on 6.08.2022.
//

import UIKit
import SDWebImage

class OfficeImagesCell: UICollectionViewCell {

    var viewModel:OfficeDetail.Fetch.ViewModel?
    
    @IBOutlet weak var officeImagesView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(images: String){

         officeImagesView.sd_setImage(with: URL(string: images))


    }

}
