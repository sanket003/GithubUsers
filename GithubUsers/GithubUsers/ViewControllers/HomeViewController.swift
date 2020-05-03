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
    @IBOutlet weak var leftBarButton: UIBarButtonItem!
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    
    let userTableCell = "UsersTableViewCell"
    var apiResponse: APIResponseModel?
    var isFromSearch = false
    var searchForUser = ""
    var arrSorted : [SearchItemModel]?
    
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
        
        if isFromSearch
        {
            self.title = searchForUser
            leftBarButton.image = #imageLiteral(resourceName: "back")
            rightBarButton.image = UIImage.init(systemName: "")
        }
        else
        {
            self.title = "Home"
            leftBarButton.image = #imageLiteral(resourceName: "menu")
            rightBarButton.image = UIImage.init(systemName: "magnifyingglass")
        }
        
        getUserList()
    }
    
    func reloadData()
    {
        var attStr : NSAttributedString?
        
        if isFromSearch
        {
            let text : NSString = "Search Results for `\(searchForUser)`" as NSString
            
            attStr = self.attributedString(from: text, boldRange: text.range(of: searchForUser as String))
        }
        else
        {
            let count : NSString = "\(apiResponse?.total_count ?? 0)" as NSString
            let text : NSString = "Showing \(count) results" as NSString
            
            attStr = self.attributedString(from: text, boldRange: text.range(of: count as String))
        }
        
        lbl_searchResults.attributedText = attStr
    }
    
    @IBAction func onClickMenu(_ sender: Any) {
        if leftBarButton.image == #imageLiteral(resourceName: "back")
        {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func onClickSearch(_ sender: Any) {
        
        if rightBarButton.image == UIImage.init(systemName: "magnifyingglass")
        {
            let searchNavVC = self.storyboard?.instantiateViewController(identifier: "SearchNavVC") as! UINavigationController
            searchNavVC.modalPresentationStyle = .fullScreen
            self.present(searchNavVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func onClickSortBy(_ sender: Any) {
        let alert = UIAlertController.init(title: "Sort By", message: "", preferredStyle: .actionSheet)
        
        
        let AtoZ = UIAlertAction.init(title: "Name (A - Z)", style: .default) { (action) in
            
            self.arrSorted = self.apiResponse?.items?.sorted(by: { (item1, item2) -> Bool in
                return (item1.login ?? "" ).localizedCaseInsensitiveCompare(item2.login ?? "") == ComparisonResult.orderedAscending
            })
            
            let text : NSString = "Sort By Name (A - Z)" as NSString
            let attStr = self.attributedString(from: text, boldRange: text.range(of: "Name (A - Z)" as String))
            self.btn_sortBy.setAttributedTitle(attStr, for: .normal)
            
            self.tblView_users.reloadData()
        }
        
        let ZtoA = UIAlertAction.init(title: "Name (Z - A)", style: .default) { (action) in
            self.arrSorted = self.apiResponse?.items?.sorted(by: { (item1, item2) -> Bool in
                return (item1.login ?? "" ).localizedCaseInsensitiveCompare(item2.login ?? "") == ComparisonResult.orderedDescending
            })
            
            let text : NSString = "Sort By Name (Z - A)" as NSString
            let attStr = self.attributedString(from: text, boldRange: text.range(of: "Name (Z - A)" as String))
            self.btn_sortBy.setAttributedTitle(attStr, for: .normal)
            
            self.tblView_users.reloadData()
        }
        
        let RankUp = UIAlertAction.init(title: "Rank ↑", style: .default) { (action) in
            self.arrSorted = self.apiResponse?.items?.sorted(by: { (item1, item2) -> Bool in
                return (item1.score ?? 0) > (item2.score ?? 0)
            })
            
            let text : NSString = "Sort By Rank ↑" as NSString
            let attStr = self.attributedString(from: text, boldRange: text.range(of: "Rank ↑" as String))
            self.btn_sortBy.setAttributedTitle(attStr, for: .normal)
            
            self.tblView_users.reloadData()
        }
        
        let RankDown = UIAlertAction.init(title: "Rank ↓", style: .default) { (action) in
            self.arrSorted = self.apiResponse?.items?.sorted(by: { (item1, item2) -> Bool in
                return (item1.score ?? 0) > (item2.score ?? 0)
            })
            
            let text : NSString = "Sort By Rank ↓" as NSString
            let attStr = self.attributedString(from: text, boldRange: text.range(of: "Rank ↓" as String))
            self.btn_sortBy.setAttributedTitle(attStr, for: .normal)
            
            self.tblView_users.reloadData()
        }
        
        let Cancel = UIAlertAction.init(title: "Cancel", style: .destructive) { (action) in
            
        }
        
        alert.addAction(AtoZ)
        alert.addAction(ZtoA)
        alert.addAction(RankUp)
        alert.addAction(RankDown)
        alert.addAction(Cancel)
        
        self.present(alert, animated: true) {
            
        }
    }
    
    @objc func onClickViewDetails(_ sender: UIButton)
    {
        let userDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
        userDetailVC.userName = arrSorted?[sender.tag].login ?? "-"
        userDetailVC.avatar = arrSorted?[sender.tag].avatar_url ?? ""
        self.navigationController?.pushViewController(userDetailVC, animated: true)
    }
}

//MARK: UITableView DataSource Delegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSorted?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userTableCell, for: indexPath) as! UsersTableViewCell
        cell.lbl_userName.text = arrSorted?[indexPath.row].login
        cell.lbl_score.text = "\(arrSorted?[indexPath.row].score ?? 0)"
        cell.imgView_user?.kf.setImage(with: URL(string: arrSorted?[indexPath.row].avatar_url ?? ""))
        cell.btn_details.tag = indexPath.row
        cell.btn_details.addTarget(self, action: #selector(self.onClickViewDetails(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

// MARK: API Calling
extension HomeViewController
{
    func getUserList()
    {
        
        var apiName = ""
        
        if isFromSearch
        {
            apiName = "https://api.github.com/search/users?q=\(searchForUser)"
        }
        else
        {
            apiName = "https://api.github.com/search/users?q=repos:%3E400+followers:%3E1000"
        }
        
        APIClient().postData(parameters: nil, wholeAPIUrl: apiName, httpMethod: .get, delegate: self) { (response) in
            
            let resp = response as! [String : Any]
            do {
                
                let jsonData = try JSONSerialization.data(withJSONObject: resp, options: .prettyPrinted)
                self.apiResponse = try JSONDecoder().decode(APIResponseModel.self, from: jsonData)
                
            } catch {
                print("Unexpected error: \(error).")
            }
            
            self.arrSorted = self.apiResponse?.items
            print(self.apiResponse?.total_count ?? 0)
            
            self.reloadData()
            DispatchQueue.main.async {
                self.tblView_users.reloadData()
            }
        }
    }
}
