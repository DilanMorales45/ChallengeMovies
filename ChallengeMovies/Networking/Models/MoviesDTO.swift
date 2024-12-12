//
//  MoviesDto.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 9/12/24.
//

import Foundation

struct MovieDTO: Decodable {
    let results: [Result]?
}

struct Result: Decodable {
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

//extension MovieDTO {
//    static var mock: MovieDTO {
//        MovieDTO(title: "Terminator", voteAverage: 7.45, posterPath: "", releaseDate: "10/02/2018")
//    }
//}

extension Array where Element == MovieDTO {
    var toMovies: [commonDetails] {
        return self.flatMap { dto in
            dto.results?.map { commonDetails(dto: $0) } ?? []
        }
    }
}
