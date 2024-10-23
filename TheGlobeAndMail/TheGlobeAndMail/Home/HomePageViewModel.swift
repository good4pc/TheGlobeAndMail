//
//  HomePageViewModel.swift
//  TheGlobeAndMail
//
//  Created by Prasanth pc on 2024-10-23.
//

import Foundation

final class HomePageViewModel: ObservableObject {
    private let apiClient: ApiClientProviding
    private let urlConfigurations: UrlConfigurations
    @Published var isLoading = false
    @Published var stories: [Story] = []
    @Published var errorString: String?

    init(apiClient: ApiClientProviding = ApiClient(),
         urlconfigurations: UrlConfigurations) {
        self.apiClient = apiClient
        self.urlConfigurations = urlconfigurations
    }

    func loadHomePageContents() async {
        do {
            let request = try urlConfigurations.getUrlRequest(endPoint: .homePageListing)
            let result: Result<Recommendations, Error> = await apiClient.loadData(urlRequest: request)
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.stories = model.recommendations
                case .failure:
                    self.errorString = "error"
                }
            }
            
        } catch {
            DispatchQueue.main.async {
                self.errorString = "error"
            }
        }
    }
}
