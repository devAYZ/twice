//
//  File.swift
//  twiceNetworking
//
//  Created by Ayokunle Fatokimi on 26/05/2025.
//

import Foundation
import Alamofire

// MARK: AFNetworkClass
public final class TwiceNetworkService: TwiceNetworkServiceProtocol {
    
    @MainActor public static let shared: TwiceNetworkServiceProtocol = TwiceNetworkService()
    private init() { }
    
    /// Implement network call using Alamofire
    /// - Parameters:
    ///   - requestModel: requestModel
    ///   - completion: completion handler
    // MARK: API call
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
        
        var requestHeaders: HTTPHeaders = [
            "content-type": "application/json",
            "x-channel": "iOS",
            "X-App-Version": "1.0.0",
            "x-lang": "EN"
        ]
        requestModel.headers?.forEach {
            requestHeaders.update($0)
        }
        
        print("\n****************************STARTS Network call\n")
        print(fullURL)
        
        var request: DataRequest
        
        if let queryParams = requestModel.queryParameters {
            requestHeaders["content-type"] = nil
            request = AF.request(fullURL, method: requestMethod,
                                 parameters: queryParams,
                                 encoding: URLEncoding.default,
                                 headers: requestHeaders)
        } else {
            request = AF.request(fullURL, method: requestMethod,
                                 parameters: requestObject,
                                 encoder: JSONParameterEncoder.default,
                                 headers: requestHeaders)
        }
        
        request
            .validate()
            .responseDecodable(of: responseType) { response in
                debugPrint(response)
                print("\nCOMPLETES Network call...\n")
                //completion?(response)
                Task { @MainActor in
                    completion?(response)
                }
            }
        
    }
}
