//
//  ListCellView.swift
//  TheGlobeAndMail
//
//  Created by Prasanth pc on 2024-10-23.
//

import SwiftUI


struct HomePageListCellView: View {
    @StateObject private var viewModel: HomePageListCellViewModel
    init(viewModel: HomePageListCellViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            HStack {
                TitleAndIcon(title: viewModel.story.title,
                             showTrailingIcon: viewModel.story.showTrailingIcon)
                Spacer()
                Image(uiImage: viewModel.storyImage)
                    .resizable()
                    .frame(width: 100, height: 70)
                    .aspectRatio(contentMode: .fit)
            }
            HStack {
                Text(viewModel.story.author.displayValue)
                    .foregroundStyle(Color(uiColor: .darkGray))
                Spacer()
            }
        }
    }
}
