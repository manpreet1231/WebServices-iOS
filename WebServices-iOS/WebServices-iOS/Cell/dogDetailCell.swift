//
//  dogDetailCell.swift
//  WebServices-iOS
//
//  Created by Tajamal on 10/03/2022.
//

import Foundation
import UIKit
class dogsInfoCell: UITableViewCell {

    @IBOutlet weak var imgDog: UIImageView!
    @IBOutlet weak var lblDogBreadName: UILabel!
    
   
    @IBOutlet weak var containerView: UIView!
    
    //Set The Dog Name
    var dogNameSet: String? = ""{
        didSet{
            lblDogBreadName.text = dogNameSet ?? ""
        }
    }
    
    //Srty The Dog Image
    var dogImageSet: UIImage? = nil{
        didSet{
            if let img = dogImageSet{
                imgDog.image = img
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgDog.layer.cornerRadius = 8
        lblDogBreadName.numberOfLines = 2
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
