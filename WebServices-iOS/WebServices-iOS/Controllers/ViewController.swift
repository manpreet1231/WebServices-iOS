//
//  ViewController.swift
//  WebServices-iOS
//
//  Created by Tajamal on 10/03/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tblDogsInfo: UITableView!
    @IBOutlet weak var containerView: UIView!
    
    
    var arraybreeds = [String]()
    var images = [UIImage]()
    var valueToPass:String!
    var valueToPassImage:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBreadName()
    }
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get a reference to the second view controller
        let secondViewController = segue.destination as! previewImageController
        // Set a variable in the second view controller with the" String to pass
        secondViewController.dogBread = valueToPass
        secondViewController.dImage = valueToPassImage
    }
}

//Table view Configure data
extension  ViewController :UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraybreeds.count //total breeds count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! dogsInfoCell
        
        cell.dogNameSet = "\(indexPath.row + 1) - \(arraybreeds[indexPath.row].uppercased())"
        
        if images.count != 0{
            cell.dogImageSet = images[indexPath.row]
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 //height of cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        valueToPass = "\(arraybreeds[indexPath.row])"
        valueToPassImage = (images[indexPath.row])
        performSegue(withIdentifier: "dogsDetail", sender: self)
    }
}

//Fectch Bread And images
extension ViewController{
    
    //Fecth information from api
    func fetchBreadName(){
        
        DogAPIHelpers.fetchBreeds { [self]
            breeds in
            for (key, _) in breeds {
                self.arraybreeds.append(key)
            }
            tblDogsInfo.reloadData()
            fetchBreadImage()
        }
    }
    
    //Fecth Random Image information of Bread
    func fetchBreadImage() {
        arraybreeds.forEach { (dogsBread) in
            ActivityController.shared.showActivityIndicator(uiView: containerView)
            DogAPIHelpers.fetchBreedImage(breed: dogsBread){ [self]
                Images in
                images.append(Images)
                relodData()
            }
        }
    }
    
    //Reload TableView After Fetch The Image of Bread
    func  relodData() {
        if images.count == arraybreeds.count{
            tblDogsInfo.reloadData()
            ActivityController.shared.hideActivityIndicator(uiView: containerView)
        }
    }
}


