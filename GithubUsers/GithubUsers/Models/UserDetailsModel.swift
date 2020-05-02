//
//  UserDetailsModel.swift
//  GithubUsers
//
//  Created by Sanket Bhavsar on 02/05/20.
//  Copyright © 2020 Sanket Bhavsar. All rights reserved.
//

import Foundation

struct UserDetailsModel: Codable {
    let name: String?
    let html_url: String?
    let description: String?
    let created_at: String?
    let language: String?
}
