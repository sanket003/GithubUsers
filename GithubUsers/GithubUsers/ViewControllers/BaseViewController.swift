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
    
    func attributedString(from string: NSString, boldRange: NSRange?) -> NSAttributedString {
        let fontSize = CGFloat(12.0)
        let attrs = [
            NSAttributedString.Key.font: UIFont.init(name: "Lato-Bold", size: fontSize),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        let nonBoldAttribute = [
            NSAttributedString.Key.font: UIFont.init(name: "Lato-Regular", size: fontSize),
        ]
        let attrStr = NSMutableAttributedString(string: string as String, attributes: nonBoldAttribute as [NSAttributedString.Key : Any])
        if let range = boldRange {
            attrStr.setAttributes(attrs as [NSAttributedString.Key : Any], range: range)
        }
        return attrStr
    }
}

extension String {
    func changeDateFormat() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let date = dateFormatter.date(from: self) ?? Date()
        
        let finalDateFormatter = DateFormatter()
        finalDateFormatter.dateFormat = "dd-MM-yy"
        return finalDateFormatter.string(from: date)
    }
}
