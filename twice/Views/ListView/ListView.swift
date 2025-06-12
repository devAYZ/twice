//
//  ListView.swift
//  twice
//
//  Created by Ayokunle Fatokimi on 26/05/2025.
//

import SwiftUI

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
                        
                        if #available(iOS 16.0, *) {
                            listView
                                .scrollDismissesKeyboard(.immediately)
                        } else {
                            listView
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
    
    var listView: some View {
        List(vmListView.filteredListItems, id: \.id) { user in
            NavigationLink(destination: DetailsUIView(user: user)) {
                ListCellView(user: user)
            }
        }
        .refreshable {
            vmListView.getListItems()
        }
    }
    
    private func handleSearchText() {
        if vmListView.searchText.isEmpty {
            return vmListView.filteredListItems = vmListView.listItems
        } else {
            vmListView.filteredListItems = vmListView.listItems.filter { $0.login.unwrap.lowercased().contains(vmListView.searchText.lowercased())
            }
        }
    }
}

extension ListView: ListViewDelegate {
    
    func handleDidFetchData(data: [GithubUsersResponse]) {
        vmListView.listItems = data
        vmListView.filteredListItems = data
        CacheManager.shared.cacheObject(object: data, key: .listItems)
    }
    
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
