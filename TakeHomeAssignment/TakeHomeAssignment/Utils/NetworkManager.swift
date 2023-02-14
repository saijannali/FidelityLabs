//
//  NetworkManager.swift
//  TakeHomeAssignment
//
//  Created by Sai Jannali on 2/11/23.
//

import Foundation
import Combine

class NetworkManager {
    
    enum NetworkingError: LocalizedError {
        case invalidURL
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .invalidURL: return "Invalid URL"
            case .badURLResponse(url: let url): return "Bad response from URL: \(url)"
            case .unknown: return "Unknown error occured"
            }
        }
        
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error>{
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0, url: url) })
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data{
        guard let res = output.response as? HTTPURLResponse, res.statusCode >= 200 && res.statusCode < 300  else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>){
        switch completion{
        case .finished:
            break
        case .failure(let err):
            print(err.localizedDescription)
        }
    }
}

