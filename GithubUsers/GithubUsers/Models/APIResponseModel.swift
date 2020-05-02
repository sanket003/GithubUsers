//
//  APIResponseModel.swift
//  GithubUsers
//
//  Created by Sanket Bhavsar on 01/05/20.
//  Copyright © 2020 Sanket Bhavsar. All rights reserved.
//

import Foundation

struct APIResponseModel: Codable {
    let total_count: Int?
    let incomplete_results: Bool?
    let items: [SearchItemModel]?
}
