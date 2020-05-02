//
//  UserDetailsViewController.swift
//  GithubUsers
//
//  Created by Sanket Bhavsar on 02/05/20.
//  Copyright © 2020 Sanket Bhavsar. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {

    @IBOutlet weak var imgView_user: UIImageView!
    @IBOutlet weak var lbl_userName: UILabel!
    @IBOutlet weak var btn_viewProfile: UIButton!
    @IBOutlet weak var lbl_repoName: UILabel!
    @IBOutlet weak var lbl_repoDesc: UILabel!
    @IBOutlet weak var lbl_repoURL: UILabel!
    @IBOutlet weak var lbl_repoLang: UILabel!
    @IBOutlet weak var lbl_repoCreationDate: UILabel!
    
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
    }
    
    func reloadData()
    {
        
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
