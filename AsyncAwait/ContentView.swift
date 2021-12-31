//
//  ContentView.swift
//  AsyncAwait
//
//  Created by 宮本光直 on 2021/12/31.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ContentViewModel

    var body: some View {
        ScrollView {
            ForEach(viewModel.items) { item in
                GithubItemView(item: item)
            }
        }
    }
}

struct GithubItemView: View {
    var item: Github

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: item.owner.avatarUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
                    .tint(.cyan)
            }
            .frame(width: 40, height: 40)
            .mask(RoundedRectangle(cornerRadius: 20))
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(width: 50, height: 50)
            .padding()

            VStack(alignment: .leading, spacing: 2) {
                Text(item.fullName)
                    .font(.body)
                Label(String(item.stargazersCount),
                      systemImage: "star")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .symbolRenderingMode(.multicolor)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
