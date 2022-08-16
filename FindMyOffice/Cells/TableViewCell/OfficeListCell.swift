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

class OfficeListCell: UITableViewCell {

    var delegate: favoriteActions?

    var ViewModel: Offices.Fetch.ViewModel.Office?
    
    
    @IBOutlet weak var roomsLabel: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var officeView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        favButton.imageView?.contentMode = .scaleAspectFit
        

    }
    
    
    @IBAction func favButton(_ sender: UIButton) {
        delegate?.favSelected(viewModel: ViewModel!)
        print("bastın")
        
        
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
