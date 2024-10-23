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
         urlconfigurations: UrlConfigurations = UrlConfigurations(baseUrl: BaseUrlFactory.url)) {
        self.apiClient = apiClient
        self.urlConfigurations = urlconfigurations
    }

    func loadHomePageContents() async {
        showActivityIndicator(true)
        do {
            let request = try urlConfigurations.getUrlRequest(endPoint: .homePageListing)
            let result: Result<Recommendations, Error> = await apiClient.loadData(urlRequest: request)
            DispatchQueue.main.async {
                self.showActivityIndicator(false)
                switch result {
                case .success(let model):
                    self.stories = model.recommendations
                    self.errorString = nil
                case .failure:
                    self.errorString = "error"
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.showActivityIndicator(false)
                self.errorString = "error"
            }
        }
    }

    private func showActivityIndicator(_ show: Bool) {
        DispatchQueue.main.async {
            self.isLoading = show
        }
    }
}
