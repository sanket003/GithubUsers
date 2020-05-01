//
//  BaseViewController.swift

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func showAlertWithErrorMessage(_ message:String)
    {
        let alert = UIAlertController.init(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default) { (action: UIAlertAction) -> Void in }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func startLoading()
    {
        //print("Start")
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        
    }
    
    func stopLoading()
    {
        //print("Stop")
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}
