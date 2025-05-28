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
    
    // Static helper to create SUT for each test
    private static func makeSUT(apiFlow: MockNetworkServiceFlow?) -> (ListViewModel, MockListViewDelegate) {
        let networkService = MockNetworkService(apiFlow: apiFlow)
        let viewModel = ListViewModel(networkService: networkService)
        let viewDelegate = MockListViewDelegate()
        viewModel.attachView(view: viewDelegate)
        return (viewModel, viewDelegate)
    }
    
    @Test func successFetchList() {
        let (sut, mockViewDelegate) = Self.makeSUT(apiFlow: .successFetchList)
        sut.getListItems()
        #expect(mockViewDelegate.receivedListData?.count == 2)
        #expect(mockViewDelegate.receivedListData?.first?.login == "ayo")
    }
    
    @Test func sortedListByLogin() {
        let (sut, mockViewDelegate) = Self.makeSUT(apiFlow: .successFetchList)
        
        sut.getListItems()

        let list = mockViewDelegate.receivedListData?.compactMap { $0.login }
        #expect((list == list?.sorted()))
    }

    @Test func failureFetchList() {
        let (sut, mockViewDelegate) = Self.makeSUT(apiFlow: .failFetchList)
        sut.getListItems()
        #expect(mockViewDelegate.receivedError != nil)
        #expect(mockViewDelegate.receivedError?.contains("Custom Error fetching list") ?? false)
    }

    // Testing Loader
    @Test func loaderStateDuringSuccessFetch() {
        let (sut, mockViewDelegate) = Self.makeSUT(apiFlow: .successFetchList)
        sut.getListItems()
        #expect(mockViewDelegate.loaderShownStates.count == 2)
        #expect(mockViewDelegate.loaderShownStates.first == true)  // Loader shown
        #expect(mockViewDelegate.loaderShownStates.last == false)  // Loader dismissed
    }

    @Test func loaderStateDuringFailureFetch() {
        let (sut, mockViewDelegate) = Self.makeSUT(apiFlow: .failFetchList)
        sut.getListItems()
        #expect(mockViewDelegate.loaderShownStates.count == 2)
        #expect(mockViewDelegate.loaderShownStates.first == true)  // Loader shown
        #expect(mockViewDelegate.loaderShownStates.last == false)  // Loader dismissed
    }
}
