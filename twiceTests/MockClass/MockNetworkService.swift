//
//  MockNetworkService.swift
//  twiceTests
//
//  Created by Ayokunle Fatokimi on 28/05/2025.
//

import Foundation
@testable import twice
import twiceNetworking
import Alamofire

enum MockNetworkServiceFlow {
    case successFetchList
    case failFetchList
}

struct MockNetworkService: TwiceNetworkServiceProtocol {
    var apiFlow: MockNetworkServiceFlow?
    
    func makeNetworkCall<Q, A>(with requestModel: TwiceNetworkServicelModel<Q, A>, completion: ((AFDataResponse<A>) -> ())?) where Q : Decodable, Q : Encodable, Q : Sendable, A : Decodable, A : Sendable {
        switch apiFlow {
        case .successFetchList:
            completion?(fetchListMockSuccesResponse())
        case .failFetchList:
            completion?(fetchListMockFailResponse())
        default:
            break
        }
    }
    
    func fetchListMockSuccesResponse<T>() -> AFDataResponse<T> {
        return DataResponse(
            request: nil, response: nil, data: nil, metrics: nil,
            serializationDuration: 1,
            result: .success(
                [
                    GithubUsersResponse(
                        login: "becky",
                        id: 02,
                        avatarUrl: "api.https://avatarUrl.com/becky",
                        htmlUrl: "https://htmlUrl.com/becky",
                        type: "user",
                        url: "api.https://url.com/becky"
                    ),
                    GithubUsersResponse(
                        login: "ayo",
                        id: 01,
                        avatarUrl: "api.https://avatarUrl.com/ayo",
                        htmlUrl: "https://htmlUrl.com/ayo",
                        type: "admin",
                        url: "api.https://url.com/ayo"
                    )
                ] as! T
            )
        )
    }
    
    func fetchListMockFailResponse<T>() -> AFDataResponse<T> {
        return DataResponse(
            request: nil, response: nil, data: nil, metrics: nil,
            serializationDuration: 1,
            result: .failure(
                AFError.responseValidationFailed(reason: .customValidationFailed(
                    error: NSError(domain: "", code: 400,
                                   userInfo: [NSLocalizedDescriptionKey: "Custom Error fetching list"])
                ))
            )
        )
    }
}
