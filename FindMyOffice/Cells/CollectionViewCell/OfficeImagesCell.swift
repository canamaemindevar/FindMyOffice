//
//  OfficeImagesCell.swift
//  FindMyOffice
//
//  Created by Emincan on 6.08.2022.
//

import UIKit

class OfficeImagesCell: UICollectionViewCell {

    var viewModel:OfficeDetail.Fetch.ViewModel?
    
    @IBOutlet weak var officeImagesView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(images: String){

         officeImagesView.sd_setImage(with: URL(string: images))

//        viewModel.images?.forEach({ result in
//            officeImagesView.sd_setImage(with: URL(string: result))
//        })

    }

}
