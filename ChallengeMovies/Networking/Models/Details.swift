//
//  Details.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 16/12/24.
//

import Foundation

class details: NSObject {
    let title: String
    let voteAverage: Double
    let posterPath: String
    let backdropPath: String
    let overview: String
    let genres: [Genre]
    private let releaseDate: Date?
    
    var releaseDateFullFormat: String {
        self.releaseDate?.toStringWithFormat("EEEE dd 'de' MMMM 'del' yyyy") ?? "Próximamente"
    }

    var releaseDateShortFormat: String {
        self.releaseDate?.toStringWithFormat("dd MMMM yyyy") ?? "Próximamente"
    }
    
    var info: String {
        "\(self.title)"
    }
    
    init(dto: DetailsDTO) {
        self.title = dto.title ?? ""
        self.voteAverage = dto.voteAverage ?? 0.0
        self.posterPath = "https://image.tmdb.org/t/p/original" + (dto.posterPath ?? "")
        self.backdropPath = "https://image.tmdb.org/t/p/original" + (dto.backdropPath ?? "")
        self.overview = dto.overview ?? ""
        self.genres = dto.genres ?? []
        self.releaseDate = dto.releaseDate?.toDateWithFormat("yyyy-MM-dd")
    }
}
