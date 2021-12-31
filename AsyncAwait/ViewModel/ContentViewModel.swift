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
                        self.items = try await GithubRepository
                            .fetchGithub(
                                url: APIURLConst.githubRepo()
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
