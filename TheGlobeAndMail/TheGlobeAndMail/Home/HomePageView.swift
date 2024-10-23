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
        Text("Hellow")
    }
}


