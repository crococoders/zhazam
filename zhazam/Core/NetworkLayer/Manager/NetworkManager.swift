//
//  NetworkManager.swift
//  zhazam
//
//  Created by Beknar Danabek on 07/08/2018.
//  Copyright © 2018 crococoders. All rights reserved.
//

import Foundation

// TODO: Separate Services, use DIP
final class NetworkManager: Handler {
    typealias GameResultResponse = ((_ score: GameResult?, _ error: Error?) -> Void)
    typealias LeaderBoardResponse = ((_ leaderBoard: [LeaderBoardResult]?, _ error: Error?) -> Void)
    
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
}
