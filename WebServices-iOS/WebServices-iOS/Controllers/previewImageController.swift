//
//  previewImageController.swift
//  WebServices-iOS
//
//  Created by Tajamal on 10/03/2022.
//

import UIKit

class previewImageController: UIViewController {
    
    
    @IBOutlet weak var dogImage: UIImageView!
   
    @IBOutlet var lblDogName: UILabel!
    
    var dogBread : String? =  ""
    
    var dImage : UIImage? =  nil
    
    @IBAction func btnReload(_ sender: Any) {
        fetchInfo()
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI(){
        self.dogImage.image = dImage
        dogImage.layer.cornerRadius = 8
        lblDogName.text = dogBread?.uppercased()
    }
    
    func fetchInfo(){
        DogAPIHelpers.fetchBreedImage(breed: dogBread ?? ""){ [self]
            breeds in
            
            self.dogImage.image = breeds
        }
    }
}
