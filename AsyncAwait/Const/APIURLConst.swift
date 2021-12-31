//
//  APIURLConst.swift
//  AsyncAwait
//
//  Created by 宮本光直 on 2021/12/31.
//

import SwiftUI

struct APIURLConst {
    static func githubRepo() -> URL {
        let targetURL = URL(string: "https://api.github.com/search/repositories?q=swift")!
        return targetURL
    }
}
