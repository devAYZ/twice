//
//  ListViewModelTests.swift
//  twiceTests
//
//  Created by Ayokunle Fatokimi on 28/05/2025.
//

import Testing
@testable import twice

@Suite("Fetch list operations")
struct ListViewModelTests {
    
    var sut: ListViewModel!
    var mockViewDelegate: MockListViewDelegate!
    var mockNetworkService: MockNetworkService!
    
    private mutating func setupSUTAPIFlow(apiFlow: MockNetworkServiceFlow?) {
        mockNetworkService = MockNetworkService(apiFlow: apiFlow)
        sut = ListViewModel(networkService: mockNetworkService)
        mockViewDelegate = MockListViewDelegate()
        sut.attachView(view: mockViewDelegate)
    }
    
    @Test func myFirstTest() {
      #expect(1 == 1)
    }
    
    @Test mutating func successFetchList() {
        setupSUTAPIFlow(apiFlow: .successFetchList)
        sut.getListItems()
        #expect(mockViewDelegate.receivedListData?.count == 1)
    }

}
