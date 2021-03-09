//
//  HomeTableViewCell.swift
//  challenge-pag
//
//  Created by Leonardo Sugano on 08/03/21.
//

import UIKit
import SDWebImage

class HomeTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var beerImageView: RoundedImageView?
    @IBOutlet weak var alcoholContentLabel: UILabel?
    
    //MARK: - Lets
    
    //MARK: - Vars
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    //MARK: - Setup
    func setupCellWithBeer(beer: BeerModel) {
        self.nameLabel?.text = beer.name
        self.alcoholContentLabel?.text = "Teor alcoólico: \( beer.alcoholContent?.doubleValue ?? 0)%"
        self.beerImageView?.sd_setImage(with: URL(string: beer.imageBeer ?? ""), placeholderImage: UIImage(named: "beer-placeholder"))
    }

}
