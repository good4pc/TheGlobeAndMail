//
//  ContentView.swift
//  TheGlobeAndMail
//
//  Created by Prasanth pc on 2024-10-23.
//

import SwiftUI

struct ContentView: View {
    let urlConfiguration = UrlConfigurations(baseUrl: "https://d2c9087llvttmg.cloudfront.net/")
    var body: some View {
        let viewModel = HomePageViewModel(urlconfigurations: urlConfiguration)
        HomePageView(viewModel: viewModel)
            .onAppear(perform: {
                Task {
                    await viewModel.loadHomePageContents()
                }
            })
    }
}
