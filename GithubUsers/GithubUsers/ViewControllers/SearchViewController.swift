//
//  SearchViewController.swift
//  GithubUsers
//
//  Created by Sanket Bhavsar on 02/05/20.
//  Copyright © 2020 Sanket Bhavsar. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initialise()
    }
    
    func initialise() {
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
}

extension SearchViewController: UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Cancelled")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let homeVC = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        homeVC.isFromSearch = true
        homeVC.searchForUser = searchBar.text ?? ""
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
}
