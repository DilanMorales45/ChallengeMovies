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
    
    func fetchMultipleMoviesDetail(movieIds: [String], _ success: @escaping Success) {
        let dispatchGroup = DispatchGroup()
        var detailsDTOs = [DetailsDTO]()
        
        for movieId in movieIds {
            dispatchGroup.enter()
            
            let service = MoviesDetailWebService(idMovie: movieId, language: language)
            service.fetch { details in
                if let detail = details.first {
                    detailsDTOs.append(detail)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            success(detailsDTOs)
        }
    }
}
