//
//  NetworkService.swift
//  twiceNetworking
//
//  Created by Ayokunle Fatokimi on 26/05/2025.
//

import Foundation
import Alamofire

/// A network service class that performs API calls using Alamofire.
public final class TwiceNetworkService: TwiceNetworkServiceProtocol {
    
    /// Creates a new instance of `TwiceNetworkService`.
    public init() { }
    
    /// Makes a network call using Alamofire with the provided request model.
    /// - Parameters:
    ///   - requestModel: A model containing all request details, including URL, method, headers, parameters, and expected response type.
    ///   - completion: An optional completion handler called with the decoded response.
    /// ```swift
    /// Usage:
    /// let networkService: TwiceNetworkServiceProtocol = TwiceNetworkService()
    /// networkService.makeNetworkCall(with: getListRequestObject()) { response in
    /// switch response.result {
    ///  case .success(let data):
    ///       print(data)
    ///  case .failure(let error):
    ///       print(error.localizedDescription)
    ///   }
    /// }
    ///
    /// Model:
    ///  func getListRequestObject()
    ///  -> TwiceNetworkServicelModel<SampleRequest, SampleResponse> {
    ///     return TwiceNetworkServicelModel(
    ///         baseUrl: "acb.com",
    ///         endpoint: "/abc",
    ///         requestMethod: .get,
    ///        requestObject: SampleRequest(),
    ///        responseType: SampleResponse.self
    ///    )
    /// }
    /// ```
    //
    public func makeNetworkCall<Q: Codable & Sendable, A: Decodable & Sendable>(
        with requestModel: TwiceNetworkServicelModel<Q, A>, completion: (@Sendable (AFDataResponse<A>) -> ())?
    ) {
        
        let requestObject =  requestModel.requestObject
        let requestMethod = requestModel.requestMethod
        let responseType = requestModel.responseType
        
        guard let base = URL(string: "https://" + requestModel.baseUrl) else {
            print("Invalid base URL")
            return
        }
        let fullURL = base.appendingPathComponent(requestModel.endpoint).absoluteString
        
        // Construct default request headers
        var requestHeaders: HTTPHeaders = [
            "content-type": "application/json",
            "x-channel": "iOS",
            "x-lang": "EN"
        ]
        // Update headers with any additional headers from the request model
        requestModel.headers?.forEach {
            requestHeaders.update($0)
        }
        
        print("\n****************************STARTS Network call\n")
        print(fullURL)
        
        var request: DataRequest
        
        // If query parameters exist, set content-type to nil and encode parameters as URL query parameters
        if let queryParams = requestModel.queryParameters {
            requestHeaders["content-type"] = nil
            request = AF.request(fullURL, method: requestMethod,
                                 parameters: queryParams,
                                 encoding: URLEncoding.default,
                                 headers: requestHeaders)
        } else {
            // Otherwise, encode the request object as JSON in the request body
            request = AF.request(fullURL, method: requestMethod,
                                 parameters: requestObject,
                                 encoder: JSONParameterEncoder.default,
                                 headers: requestHeaders)
        }
        
        // Validate the response and decode it into the expected response type
        request
            .validate()
            .responseDecodable(of: responseType) { response in
                //debugPrint(response)
                print("\nCOMPLETES Network call...\n")
                Task { @MainActor in
                    completion?(response)
                }
            }
        
    }
}
