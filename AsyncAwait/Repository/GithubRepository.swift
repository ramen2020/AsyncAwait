//
//  GithubRepository.swift
//  AsyncAwait
//
//  Created by 宮本光直 on 2021/12/31.
//

import SwiftUI

final class GithubRepository {
    static func fetchGithub(url: URL) async throws -> Githubs {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                  throw APIError.other
              }
        return try JSONDecoder().decode(Githubs.self, from: data)
    }
}
