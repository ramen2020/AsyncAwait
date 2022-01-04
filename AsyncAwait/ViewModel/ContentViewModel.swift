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
            .sink { [weak self] in
                guard let self = self else {return}
                Task {
                    let getItems = try await GithubRepository
                        .fetchGithub(
                            url: APIURLConst.githubRepo()
                        )
                        .items
                    DispatchQueue.main.async {
                        self.items = getItems
                    }
                }
            }.store(in: &cancellables)
        
        self.fetchGithubData.send(Void())
    }
}
