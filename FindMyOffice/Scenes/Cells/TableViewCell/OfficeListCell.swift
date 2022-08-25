//
//  OfficeListCell.swift
//  FindMyOffice
//
//  Created by Emincan on 6.08.2022.
//

import UIKit
import SDWebImage


protocol favoriteActions{
    func favSelected(viewModel: Offices.Fetch.ViewModel.Office)
}
protocol deleteFavAction{
    func favDeleted(viewModel: Offices.Fetch.ViewModel.Office)
}

class OfficeListCell: UITableViewCell {

    var favoriteActionsdelegate: favoriteActions?
    var favDeletedDelegate: deleteFavAction?

    var ViewModel: Offices.Fetch.ViewModel.Office?
    
    
    @IBOutlet weak var roomsLabel: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var officeView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var favedBtn = true
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        favButton.imageView?.contentMode = .scaleAspectFit
        favButton.tintColor = .black

    }
    
    
    @IBAction func favButton(_ sender: UIButton) {
        if favedBtn  == true {
            favedBtn = false
            favButton.tintColor = .yellow
            favButton.setImage(UIImage(named: "custom.star.circle"), for: .highlighted)
            //favButton.foregroundColor
            favoriteActionsdelegate?.favSelected(viewModel: ViewModel!)
            print("bastın")
        } else {
            favButton.tintColor = .white
            favButton.setImage(UIImage(named: "custom.star.circle"), for: .normal)
            favedBtn = true
            favDeletedDelegate?.favDeleted(viewModel: ViewModel!)
            print("sildim")
        }
       
        /*
         let imageView = UIImageView(image: image)
         imageView.tintColor = .systemPink
         */
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func configure(viewModel: Offices.Fetch.ViewModel.Office) {
        nameLabel.text = viewModel.name!
        roomsLabel.text = "Rooms: \(viewModel.rooms!)"
        self.officeView.sd_setImage(with: URL(string: viewModel.image ?? ""))
        
        self.ViewModel = viewModel
        
    }
    
}
