//
//  MoviesWebService.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 9/12/24.
//

import Alamofire
import Foundation

protocol MoviesWebServiceProtocol {
    typealias Success = (_ movieDTO: [MovieDTO]) -> Void
    func fetch(_ success: @escaping Success)
}

struct MoviesWebService: MoviesWebServiceProtocol {
    
    var language: String
    var urlString: String
    
    init(language: String) {
        self.language = language
        self.urlString = Environment.baseURL + "176de15e8c8523a92ff640f432966c9c&language=\(language)"
    }
    
    func fetch(_ success: @escaping Success) {
        AF.request(urlString, method: .get).response { dataResponse in
            guard let data = dataResponse.data else {
                success([])
                return
            }
            
            do {
                let response = try JSONDecoder().decode(MovieDTO.self, from: data)
                success([response])
            } catch {
                print("Error decoding JSON: \(error)")
                success([])
            }
        }
    }
}

//struct MoviesWebServiceMock: MoviesWebServiceProtocol {
//    func fetch(_ success: @escaping Success) {
//        success([MovieDTO.mock, MovieDTO.mock, MovieDTO.mock, MovieDTO.mock])
//    }
//}
