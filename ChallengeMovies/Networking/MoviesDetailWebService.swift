//
//  MoviesDetailWebService.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 16/12/24.
//

import UIKit
import Alamofire

protocol MoviesDetailWebServiceProtocol {
    typealias Success = (_ detailDTO: [DetailsDTO]) -> Void
    func fetch(_ success: @escaping Success)
}

struct MoviesDetailWebService: MoviesDetailWebServiceProtocol{
    
    var idMovie: String
    var urlString: String
    var language: String
    
    init(idMovie: String, language: String) {
        self.idMovie = idMovie
        self.language = language
        self.urlString = Environment.detailsURL + "\(idMovie)?api_key=752cd23fdb3336557bf3d8724e115570&language=\(language)"
    }
    
    func fetch(_ success: @escaping Success) {
        AF.request(urlString, method: .get).response { dataResponse in
            guard let data = dataResponse.data else {
                success([])
                return
            }
            
            do {
                let response = try JSONDecoder().decode(DetailsDTO.self, from: data)
                success([response])
            } catch {
                print("Error decoding JSON: \(error)")
                success([])
            }
        }
    }
}
