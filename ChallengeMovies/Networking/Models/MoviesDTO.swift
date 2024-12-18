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

extension MovieDTO {
    static var mock: MovieDTO {
        return MovieDTO(
            results: [
                Result(
                    adult: false,
                    backdropPath: "/path/to/backdrop.jpg",
                    genreIDS: [28, 12, 878], // Ejemplo de géneros
                    id: 1,
                    originalTitle: "Terminator",
                    overview: "Un hombre del futuro es enviado al pasado para eliminar a una mujer que dará a luz al líder de la resistencia.",
                    popularity: 78.5,
                    posterPath: "/aosm8NMQ3UyoBVpSxyimorCQykC.jpg",
                    releaseDate: "1984-10-26",
                    title: "Terminator",
                    video: false,
                    voteAverage: 7.45,
                    voteCount: 10234
                )
            ]
        )
    }
}


extension Array where Element == MovieDTO {
    var toMovies: [commonDetails] {
        return self.flatMap { dto in
            dto.results?.map { commonDetails(dto: $0) } ?? []
        }
    }
}
