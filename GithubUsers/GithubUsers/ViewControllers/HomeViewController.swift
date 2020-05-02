//
//  HomeViewController.swift
//  GithubUsers
//
//  Created by Sanket Bhavsar on 02/05/20.
//  Copyright © 2020 Sanket Bhavsar. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var btn_sortBy: UIButton!
    @IBOutlet weak var lbl_searchResults: UILabel!
    @IBOutlet weak var tblView_users: UITableView!
    
    let userTableCell = "UsersTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialise()
    }

    func initialise() {
        tblView_users.dataSource = self
        tblView_users.delegate = self
        
        tblView_users.register(UINib(nibName: userTableCell, bundle: nil), forCellReuseIdentifier: userTableCell)
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = #colorLiteral(red: 0.3018810749, green: 0.431027174, blue: 0.7103923559, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "Lato-Bold", size: 20.0) ?? UIFont.systemFont(ofSize: 20.0)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
    
    @IBAction func onClickSearch(_ sender: Any) {
    
    }
    
    @IBAction func onClickSortBy(_ sender: Any) {
    
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userTableCell, for: indexPath) as! UsersTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}
