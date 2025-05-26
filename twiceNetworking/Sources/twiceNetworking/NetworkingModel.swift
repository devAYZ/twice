//
//  File.swift
//  twiceNetworking
//
//  Created by Ayokunle Fatokimi on 26/05/2025.
//

import Foundation
import Alamofire

public protocol TwiceNetworkServiceProtocol {
    /// Blueprint network call using Alamofire
    /// - Parameters:
    ///   - urlString: urlString
    ///   - completion: completion handler
    func makeNetworkCall<Q: Codable & Sendable, A: Decodable & Sendable>(
        with requestModel: TwiceNetworkServicelModel<Q, A>,
        completion: (@Sendable (AFDataResponse<A>) -> ())?
    )
}

public struct EmptyRequest: Codable & Sendable {
    public init() {}
}

public typealias NetworkHeaders = HTTPHeaders
public typealias QueryParameters = Parameters

public struct TwiceNetworkServicelModel<Q: Codable & Sendable, A: Decodable & Sendable> {
    
    /// Initialisation
    /// - Parameters:
    ///   - url: The endpoint to be call
    ///   - requestMethod: HTTP request method
    ///   - requestObject: (Q: Question) Request Object
    ///   - header:
    public init(
        baseUrl: String, endpoint: String, requestMethod: HTTPMethod,
        requestObject: Q? = nil, responseType: A.Type,
        headers: NetworkHeaders? = nil, queryParameters: QueryParameters? = nil
    ) {
        self.baseUrl = baseUrl
        self.endpoint = endpoint
        self.requestMethod = requestMethod
        self.requestObject = requestObject
        self.responseType = responseType
        self.headers = headers
        self.queryParameters = queryParameters
    }
    
    public var baseUrl: String
    public var endpoint: String
    public var requestMethod: HTTPMethod
    public var requestObject: Q?
    public var responseType: A.Type
    public var headers: NetworkHeaders?
    public var queryParameters: QueryParameters?
}
