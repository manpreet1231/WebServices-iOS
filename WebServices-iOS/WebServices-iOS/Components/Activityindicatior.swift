
import Foundation
import UIKit

class ActivityController {
    static let shared = ActivityController()
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    //Show activity indicator
    func showActivityIndicator(uiView: UIView) {
        container.backgroundColor = UIColorFromHex(rgbValue: 0xffffff, alpha: 0.0)
        loadingView.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).withAlphaComponent(0.9)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10

        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.color = .white
        loadingView.addSubview(activityIndicator)
       
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
       activityIndicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        activityIndicator.centerSuperView()
        activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
        
        
        container.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        loadingView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
       
        
        
        uiView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.topAnchor.constraint(equalTo: uiView.topAnchor, constant: 0).isActive = true
        container.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 0).isActive = true
        container.bottomAnchor.constraint(equalTo: uiView.bottomAnchor, constant: 0).isActive = true
        container.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: 0).isActive = true

        activityIndicator.startAnimating()
    }

     //Hide activity indicator
    func hideActivityIndicator(uiView: UIView) {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }

    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}


