//
//  NetworkServicelModel.swift
//  twiceNetworking
//
//  Created by Ayokunle Fatokimi on 26/05/2025.
//

import Foundation
import Alamofire

/// Protocol defining the Twice Network Service using Alamofire for network calls.
public protocol TwiceNetworkServiceProtocol {
    /// Makes a network call using Alamofire.
    /// - Parameters:
    ///   - requestModel: The network request model containing request details.
    ///   - completion: Optional completion handler returning an Alamofire response.
    func makeNetworkCall<Q: Codable & Sendable, A: Decodable & Sendable>(
        with requestModel: TwiceNetworkServicelModel<Q, A>,
        completion: (@Sendable (AFDataResponse<A>) -> ())?
    )
}

/// Represents an empty request body.
public struct EmptyRequest: Codable & Sendable {
    public init() {}
}

/// Typealias for HTTP headers used in network requests.
public typealias NetworkHeaders = HTTPHeaders

/// Typealias for query parameters used in network requests.
public typealias QueryParameters = Parameters

/// Model representing the details needed to perform a network call.
public struct TwiceNetworkServicelModel<Q: Codable & Sendable, A: Decodable & Sendable> {
    
    /// Initializes a new network service model.
    /// - Parameters:
    ///   - baseUrl: Base URL of the request.
    ///   - endpoint: Specific API endpoint.
    ///   - requestMethod: HTTP method (GET, POST, etc.).
    ///   - requestObject: Request payload object of type `Q`.
    ///   - responseType: Expected response type `A`.
    ///   - headers: Optional HTTP headers.
    ///   - queryParameters: Optional query parameters.
    ///  > Tip: The requestObject, headers, queryParameters  are optional, they can be omitted where appropriate
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
    
    /// The base URL for the request.
    public var baseUrl: String
    
    /// The specific API endpoint.
    public var endpoint: String
    
    /// The HTTP method to use.
    public var requestMethod: HTTPMethod
    
    /// The request payload object.
    public var requestObject: Q?
    
    /// The expected response type.
    public var responseType: A.Type
    
    /// Optional HTTP headers.
    public var headers: NetworkHeaders?
    
    /// Optional query parameters.
    public var queryParameters: QueryParameters?
}
