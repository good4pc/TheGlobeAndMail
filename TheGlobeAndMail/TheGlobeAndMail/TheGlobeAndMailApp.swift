//
//  TheGlobeAndMailApp.swift
//  TheGlobeAndMail
//
//  Created by Prasanth pc on 2024-10-23.
//

import SwiftUI

@main
struct TheGlobeAndMailApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = HomePageViewModel()
            HomePageView(viewModel: viewModel)
                .onAppear(perform: {
                    Task {
                        await viewModel.loadHomePageContents()
                    }
                })
        }
    }
}
