//
//  MockListViewDelegate.swift
//  twiceTests
//
//  Created by Ayokunle Fatokimi on 28/05/2025.
//

import Foundation
@testable import twice

class MockListViewDelegate: ListViewDelegate {
    
    var loaderShownStates: [Bool] = []
    var receivedError: String?
    var receivedListData: [GithubUsersResponse]?
    
    func handleLoader(show: Bool) {
        loaderShownStates.append(show)
    }
    
    func handleError(message: String?) {
        receivedError = message
    }
    
    func handleDidFetchData(data: [GithubUsersResponse]) {
        receivedListData = data
    }
}
