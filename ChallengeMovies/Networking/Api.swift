//
//  Api.swift
//  ChallengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 2/11/24.
//

import Foundation

struct MovieModel {
    let title: String
    let releaseDate: String
    let popularity: Double
}

struct MoviesData: Codable {
    let results: [Result]?
}

struct Result: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
}

struct MoviesService {

    enum API {
        case popularMovies
        
        var endpoint: String {
            switch self {
            case .popularMovies:
                return "/movie/popular"
            }
        }
        
        private var apiKey: String {
            "176de15e8c8523a92ff640f432966c9c"
        }
        
        private var domain: String {
            "api.themoviedb.org"
        }
        
        var url: URL? {
            URL(string: "https://\(domain)/3/\(self.endpoint)?api_key=\(self.apiKey)&language=en")
        }
        
    }
    
    func performRequest(for endpoint: API) {
        
        if let url = endpoint.url {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error ?? "No obtiene error")
                }
                
                if let safeData = data {
                    if let movie = self.parseJSON(movieData: safeData) {
                        print(movie)
                    }
                }
            }
            
            task.resume()
            
        }
    }
    
    private func parseJSON(movieData: Data) -> [MovieModel]? {
        
        let decoder = JSONDecoder()
        
        do {
            let decodeData = try decoder.decode(MoviesData.self, from: movieData)
            let movie = decodeData.results?.map{
                MovieModel(title: $0.title ?? "", releaseDate: $0.releaseDate ?? "", popularity: $0.popularity ?? 0.0)
            }
            
            return movie
        } catch {
            return nil
        }
    }
}
