//
//  UserDetailsViewController.swift
//  GithubUsers
//
//  Created by Sanket Bhavsar on 02/05/20.
//  Copyright © 2020 Sanket Bhavsar. All rights reserved.
//

import UIKit

class UserDetailsViewController: BaseViewController {

    @IBOutlet weak var imgView_user: UIImageView!
    @IBOutlet weak var lbl_userName: UILabel!
    @IBOutlet weak var btn_viewProfile: UIButton!
    @IBOutlet weak var lbl_repoName: UILabel!
    @IBOutlet weak var lbl_repoDesc: UILabel!
    @IBOutlet weak var lbl_repoURL: UILabel!
    @IBOutlet weak var lbl_repoLang: UILabel!
    @IBOutlet weak var lbl_repoCreationDate: UILabel!
    
    var userName = ""
    var avatar = ""
    var profileUrl = ""
    var apiResponse: [UserDetailsModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialise()
    }
    
    func initialise()
    {
        self.title = "User Detail"
        
        imgView_user?.clipsToBounds = true
        imgView_user.layer.cornerRadius = 35.0
        
        btn_viewProfile.clipsToBounds = true
        btn_viewProfile.layer.cornerRadius = 3.0
        btn_viewProfile.layer.borderWidth = 0.5
        btn_viewProfile.layer.borderColor = UIColor.lightGray.cgColor
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = #colorLiteral(red: 0.3018810749, green: 0.431027174, blue: 0.7103923559, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "Lato-Bold", size: 20.0) ?? UIFont.systemFont(ofSize: 20.0)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        getUserDetails()
    }
    
    func reloadData()
    {
        imgView_user.kf.setImage(with: URL(string: avatar))
        lbl_userName.text = userName
        if apiResponse?.count ?? 0 > 0
        {
            lbl_repoName.text = apiResponse?[0].name
            lbl_repoDesc.text = apiResponse?[0].description ?? "-"
            lbl_repoURL.text = apiResponse?[0].html_url ?? "-"
            lbl_repoLang.text = apiResponse?[0].language ?? "-"
            lbl_repoCreationDate.text = apiResponse?[0].created_at?.changeDateFormat() ?? "-"
        }
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickViewProfile(_ sender: Any) {
        guard let url = URL(string: profileUrl) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func onClickRepositoryURL(_ sender: Any) {
        if apiResponse?.count ?? 0 > 0
        {
            let repoURL = apiResponse?[0].html_url ?? "-"
            
            if !(repoURL == "" || repoURL == "-")
            {
                guard let url = URL(string: repoURL) else { return }
                UIApplication.shared.open(url)
            }
        }
    }
}

// MARK: API Calling
extension UserDetailsViewController
{
    func getUserDetails()
    {
        APIClient().postData(parameters: nil, wholeAPIUrl: "https://api.github.com/users/\(userName)/repos", httpMethod: .get, delegate: self) { (response) in
            
            let resp = response as! [[String : Any]]
            do {
                
                self.apiResponse = try resp.map({
                    try JSONDecoder().decode(UserDetailsModel.self, from: try JSONSerialization.data(withJSONObject: $0, options: .prettyPrinted))
                })
                
            } catch {
                print("Unexpected error: \(error).")
            }
    
            self.reloadData()
        }
    }
}
