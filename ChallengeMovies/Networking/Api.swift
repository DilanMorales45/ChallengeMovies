//
//  Api.swift
//  ChallengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 2/11/24.
//

import Foundation

struct MovieModel {
    let title: String
    let releaseDate: String?
    let voteAverage: Double?
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
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct MoviesService {

    enum API {
        case popularMovies
        
        var endpoint: String {
            switch self {
            case .popularMovies:
                return "movie/popular"
            }
        }
        
        private var apiKey: String {
            "176de15e8c8523a92ff640f432966c9c"
        }
        
        private var domain: String {
            "api.themoviedb.org"
        }
        
        var url: URL? {
            URL(string: "https://\(self.domain)/3/\(self.endpoint)?api_key=\(self.apiKey)&language=en")
        }
        
    }
    
    func performRequest(for endpoint: API, completion: @escaping ([MovieModel]?) -> Void) {
        
        guard let url = endpoint.url else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "Error desconocido")
                completion(nil)
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Data received: \(jsonString)")
            }
            
            if let movies = self.parseJSON(movieData: data) {
                completion(movies)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    private func parseJSON(movieData: Data) -> [MovieModel]? {
        do {
            let movie = try JSONDecoder().decode(MoviesData.self, from: movieData).results?.map{
                MovieModel(title: $0.title ?? "", releaseDate: $0.releaseDate, voteAverage: $0.voteAverage)
            }
            
            return movie
        } catch {
            return nil
        }
    }
}
