//
//  HomeViewController.swift
//  GithubUsers
//
//  Created by Sanket Bhavsar on 02/05/20.
//  Copyright © 2020 Sanket Bhavsar. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: BaseViewController {

    @IBOutlet weak var btn_sortBy: UIButton!
    @IBOutlet weak var lbl_searchResults: UILabel!
    @IBOutlet weak var tblView_users: UITableView!
    
    let userTableCell = "UsersTableViewCell"
    var apiResponse: APIResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialise()
    }

    func initialise() {
        
        lbl_searchResults.text = ""
        
        tblView_users.dataSource = self
        tblView_users.delegate = self
        
        tblView_users.register(UINib(nibName: userTableCell, bundle: nil), forCellReuseIdentifier: userTableCell)
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = #colorLiteral(red: 0.3018810749, green: 0.431027174, blue: 0.7103923559, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "Lato-Bold", size: 20.0) ?? UIFont.systemFont(ofSize: 20.0)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        getUserList()
    }
    
    func reloadData()
    {
        let count : NSString = "\(apiResponse?.total_count ?? 0)" as NSString
        let text : NSString = "Showing \(count) results" as NSString
        
        let attStr = self.attributedString(from: text, boldRange: text.range(of: count as String))
        
        lbl_searchResults.attributedText = attStr
    }
    
    @IBAction func onClickSearch(_ sender: Any) {
    
    }
    
    @IBAction func onClickSortBy(_ sender: Any) {
    
    }
    
    @objc func onClickViewDetails(_ sender: UIButton)
    {
        let userDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
        self.navigationController?.pushViewController(userDetailVC, animated: true)
    }
}

//MARK: UITableView DataSource Delegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiResponse?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userTableCell, for: indexPath) as! UsersTableViewCell
        cell.lbl_userName.text = apiResponse?.items?[indexPath.row].login
        cell.lbl_score.text = "\(apiResponse?.items?[indexPath.row].score ?? 0)"
        cell.imgView_user?.kf.setImage(with: URL(string: apiResponse?.items?[indexPath.row].avatar_url ?? ""))
        cell.btn_details.tag = indexPath.row
        cell.btn_details.addTarget(self, action: #selector(self.onClickViewDetails(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

//MARK: API Calling
extension HomeViewController
{
    func getUserList()
    {
        APIClient().postData(parameters: nil, wholeAPIUrl: "https://api.github.com/search/users?q=repos:%3E400+followers:%3E1000", httpMethod: .get, delegate: self) { (response) in
            print(response?.total_count ?? 0)
            
            self.apiResponse = response
            
            self.reloadData()
            DispatchQueue.main.async {
                self.tblView_users.reloadData()
            }
        }
    }
}
