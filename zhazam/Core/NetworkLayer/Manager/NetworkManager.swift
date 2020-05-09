//
//  NetworkManager.swift
//  zhazam
//
//  Created by Beknar Danabek on 07/08/2018.
//  Copyright © 2018 crococoders. All rights reserved.
//

import Foundation

// TODO: Separate Services, use DIP
struct NetworkManager: Handler {
    static let shared = NetworkManager()
    
    typealias GameResultResponse = ((_ score: GameResult?, _ error: Error?) -> Void)
    typealias StatusResponse = ((_ result: Status?) -> Void)
    typealias UsernameResponse = ((_ username: String?) -> Void)
    typealias StatisticsResponse = ((_ statistics: Statistics?) -> Void)
    
    let router = Router<EndPoint>()
    
    func sendGameResult(with wpm: Int, completion: @escaping GameResultResponse) {
        router.request(.addGameScore(score: wpm)) { (data, response, error) in
            if error != nil {
                completion(nil, NetworkResponse.noNetwork)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData)
                        return
                    }
                    
                    do {
                        let apiResponse = try JSONDecoder().decode(GameResultApiResponse.self, from: responseData)
                        completion(apiResponse.data, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
    
    func createUser(with username: String, completion: @escaping StatusResponse) {
        router.request(.createUser(username: username)) { data, response, error in
            if error != nil {
                completion(nil)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil)
                        return
                    }
                    
                    do {
                        let apiResponse = try JSONDecoder().decode(UsernameApiResponse.self, from: responseData)
                        completion(apiResponse.status)
                    } catch {
                        completion(nil)
                    }
                case .failure:
                    completion(nil)
                }
            }
        }
    }
    
    func getUsername(completion: @escaping UsernameResponse) {
        router.request(.getUsername) { data, response, error in
            if error != nil {
                completion(nil)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil)
                        return
                    }
                    
                    do {
                        let apiResponse = try JSONDecoder().decode(UsernameApiResponse.self, from: responseData)
                        completion(apiResponse.data?.username)
                    } catch {
                        completion(nil)
                    }
                case .failure:
                    completion(nil)
                }
            }
        }
    }
    
    func getStatistics(completion: @escaping StatisticsResponse) {
        router.request(.getStatistics) { data, response, error in
            if error != nil {
                completion(nil)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil)
                        return
                    }
                    
                    do {
                        let apiResponse = try JSONDecoder().decode(StatisticsApiResponse.self, from: responseData)
                        completion(apiResponse.data)
                    } catch {
                        completion(nil)
                    }
                case .failure:
                    completion(nil)
                }
            }
        }
    }
}
