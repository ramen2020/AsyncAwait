//
//  Github.swift
//  AsyncAwait
//
//  Created by 宮本光直 on 2021/12/31.
//

import SwiftUI

struct Githubs: Codable {
    let items: [Github]
}

struct Github: Codable, Identifiable {
    let id: Int
    let fullName: String
    let stargazersCount: Int
    let htmlUrl: String
    let owner: GithubRepoOwner
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case stargazersCount = "stargazers_count"
        case htmlUrl = "html_url"
        case owner
    }
}

struct GithubRepoOwner: Codable {
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
    }
}
