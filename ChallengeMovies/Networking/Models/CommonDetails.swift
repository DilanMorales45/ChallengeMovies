//
//  Cars.swift
//  ChallengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 28/11/24.
//

import Foundation

struct commonDetails {
    let title: String
    let voteAverage: Double
    let posterPath: String
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
    
    init(dto: Result) {
        self.title = dto.title ?? ""
        self.voteAverage = dto.voteAverage ?? 0.0
        self.posterPath = "https://image.tmdb.org/t/p/original" + (dto.posterPath ?? "")
        self.releaseDate = dto.releaseDate?.toDateWithFormat("yyyy-MM-dd")
    }
}



