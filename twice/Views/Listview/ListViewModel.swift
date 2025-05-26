//
//  ListViewModel.swift
//  twice
//
//  Created by Ayokunle Fatokimi on 26/05/2025.
//

import Foundation
import twiceNetworking

protocol ListViewDelegate {
    func handleLoader(show: Bool)
    func handleError(message: String?)
}

class ListViewModel: ObservableObject {
    
    // MARK: shared
    static let shared = ListViewModel()
    
    // MARK: Properties
    @Published var showLoader = false    
    @Published var showAlert = false
    @Published var showAlert_message: String?
    
    var view: ListViewDelegate?
    var networkService: TwiceNetworkServiceProtocol?
    
    
    @Published var userList = [GithubUsersResponse]()
    
    @Published var filteredUserList = [GithubUsersResponse]()
    
    @Published var searchText: String = ""
    
    // MARK: Initialiser
    init(networkService: TwiceNetworkServiceProtocol = TwiceNetworkService()) {
        self.networkService = networkService
        filteredUserList = userList
    }
    
    func attachView(view: ListViewDelegate) {
        self.view = view
    }
    
    func getUsersList() {
        view?.handleLoader(show: true)
        networkService?.makeNetworkCall(with: githubUserRequestObject()) { response in
            switch response.result {
            case .success(let data):
                guard !data.isEmpty else {
                    self.view?.handleError(message: "Empty Data Retrieved")
                    return
                }
                let sortedData = data.sorted { $0.login.tryValue < $1.login.tryValue }
                self.userList = sortedData
                self.filteredUserList = sortedData
            case .failure(let error):
                print("devAYZ Nooo", error.localizedDescription)
                self.view?.handleError(message: error.localizedDescription)
            }
        }
    }
    
    private func githubUserRequestObject()
    -> TwiceNetworkServicelModel<EmptyRequest, [GithubUsersResponse]> {
        return TwiceNetworkServicelModel(
            baseUrl: InfoPlistFetcher[.githubBaseUrl],
            endpoint: GithubEndpoints.users.rawValue,
            requestMethod: .get,
            requestObject: nil,
            responseType: [GithubUsersResponse].self
        )
    }
}
