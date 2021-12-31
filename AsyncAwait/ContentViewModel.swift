//
//  ContentViewModel.swift
//  AsyncAwait
//
//  Created by 宮本光直 on 2021/12/31.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    
    //output
    @Published var items: [Github] = []
    
    //input
    var fetchGithubData = PassthroughSubject<Void, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchGithubData
            .receive(on: DispatchQueue.main)
            .sink { _ in
                async {
                    do {
                        self.items = try await APIClient
                            .fetchGithubRepo(
                                url: APIUrl.githubRepo()
                            )
                            .items
                    } catch let error {
                        print("::: error: ", error)
                    }
                }
            }.store(in: &cancellables)

        
        self.fetchGithubData.send(Void())
    }
}

struct APIUrl {
    static func githubRepo() -> URL {
        let targetURL = URL(string: "https://api.github.com/search/repositories?q=swift")!
        return targetURL
    }
}

final class APIClient {
    static func fetchGithubRepo(url: URL) async throws -> Githubs {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                  throw APIError.other
              }
        return try JSONDecoder().decode(Githubs.self, from: data)
    }
}


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

enum APIError: Error {
    case unknown(message: String)
    case other
    
    var message: String {
        switch self {
        case .unknown(let message):
            return message
        default:
            return "エラーです！！！！"
        }
    }
}
