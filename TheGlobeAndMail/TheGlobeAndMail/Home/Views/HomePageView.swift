//
//  HomePageView.swift
//  TheGlobeAndMail
//
//  Created by Prasanth pc on 2024-10-23.
//

import SwiftUI

struct HomePageView: View {
    @StateObject private var viewModel: HomePageViewModel
    init(viewModel: HomePageViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.black)
            } else {
                List(viewModel.stories, id: \.content_id) { story in
                    HomePageListCellView(viewModel: .init(story: story))
                }
                .listStyle(.plain)
                .navigationTitle("The globe and mail")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
