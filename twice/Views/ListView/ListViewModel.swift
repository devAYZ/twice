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
    func handleDidFetchData(data: [GithubUsersResponse])
}

final class ListViewModel: ObservableObject {
    
    // MARK: shared
    static let shared = ListViewModel()
    
    // MARK: Properties
    @Published var showLoader = false
    @Published var showAlert = false
    @Published var showAlert_message: String?
    
    private var view: ListViewDelegate?
    private var networkService: TwiceNetworkServiceProtocol?
    
    @Published var listItems = [GithubUsersResponse]()
    @Published var filteredListItems = [GithubUsersResponse]()
    @Published var searchText: String = ""
    
    // MARK: Initialiser
    init(networkService: TwiceNetworkServiceProtocol = TwiceNetworkService()) {
        self.networkService = networkService
        
        copyList()
    }
    
    func copyList() {
        filteredListItems = listItems
    }
    
    func attachView(view: ListViewDelegate) {
        self.view = view
    }
    
    func getListItems() {
        view?.handleLoader(show: true)
        networkService?.makeNetworkCall(with: getListRequestObject()) { response in
            self.view?.handleLoader(show: false)
            
            switch response.result {
            case .success(let fetchedList):
                guard !fetchedList.isEmpty else {
                    self.view?.handleError(message: "Empty Data Retrieved")
                    return
                }
                let sortedFetchedList = fetchedList.sorted {
                    $0.login.unwrap.lowercased() < $1.login.unwrap.lowercased()
                }
                self.view?.handleDidFetchData(data: sortedFetchedList)
            case .failure(let error):
                self.view?.handleError(message: error.localizedDescription)
            }
        }
    }
    
    private func getListRequestObject()
    -> TwiceNetworkServicelModel<EmptyRequest, [GithubUsersResponse]> {
        return TwiceNetworkServicelModel(
            baseUrl: InfoPlistFetcher[.githubBaseUrl],
            endpoint: GithubEndpoints.users.rawValue,
            requestMethod: .get,
            responseType: [GithubUsersResponse].self
        )
    }
}
