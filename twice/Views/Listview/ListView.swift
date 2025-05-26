//
//  ListView.swift
//  twice
//
//  Created by Ayokunle Fatokimi on 26/05/2025.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}

struct ListView: View {

    // MARK: Properties
    @ObservedObject private var vmListView = ListViewModel.shared
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    
                    if vmListView.filteredListItems.isEmpty {
                        Text("No Data Found")
                            .font(.title2)
                    } else {
                        List(vmListView.filteredListItems, id: \.id) { user in
                            NavigationLink(destination: DetailView(user: user)) {
                                ListCellView(user: user)
                            }
                        }
                    }
                }
                
                if vmListView.showLoader {
                    LoadingView()
                }
                
            }
            .navigationTitle("Main List")
        }
        .searchable(text: $vmListView.searchText)
        .onAppear {
            vmListView.attachView(view: self)
            
            guard let cachedList = CacheManager.shared
                .retrieveCachedObject(object: [GithubUsersResponse].self, key: .listItems) else {
                self.vmListView.getListItems()
                return
            }
            vmListView.listItems = cachedList
            
            vmListView.copyList()
        }
        .onChange(of: vmListView.searchText) { _ in
            handleSearchText()
        }
        .alert(vmListView.showAlert_message ?? "", isPresented: $vmListView.showAlert) {
            // Do nothing
        }
    }
}

extension ListView {
    private func handleSearchText() {
        if vmListView.searchText.isEmpty {
            return vmListView.filteredListItems = vmListView.listItems
        } else {
            vmListView.filteredListItems = vmListView.listItems.filter { $0.login.tryValue.lowercased().contains(vmListView.searchText.lowercased())
            }
        }
    }
}

extension ListView: ListViewDelegate {
    func handleLoader(show: Bool) {
        vmListView.showLoader = show
    }
    
    func handleError(message: String?) {
        vmListView.showAlert = true
        vmListView.showAlert_message = message
    }
}

#Preview {
    ListView()
}
