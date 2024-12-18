//
//  Cars.swift
//  ChallengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 28/11/24.
//

import Foundation

class commonDetails: NSObject {
    let id: Int
    let title: String
    let voteAverage: Double
    let posterPath: String
    private let releaseDate: Date?
    
    var releaseDateFullFormat: String {
        switch LocalizationManager.shared.get() {
        case "en":
            self.releaseDate?.toStringWithFormat("EEEE',' MMMM dd', ' yyyy") ?? "Coming soon"
        case "es":
            self.releaseDate?.toStringWithFormat("EEEE dd 'de' MMMM 'del' yyyy") ?? "Próximamente"
        default:
            self.releaseDate?.toStringWithFormat("EEEE dd 'de' MMMM 'del' yyyy") ?? "Próximamente"
        }
    }

    var releaseDateShortFormat: String {
        self.releaseDate?.toStringWithFormat("dd MMMM yyyy") ?? "Próximamente"
    }
    
    var info: String {
        "\(self.title)"
    }
    
    init(dto: Result) {
        self.id = dto.id ?? 0
        self.title = dto.title ?? ""
        self.voteAverage = dto.voteAverage ?? 0.0
        self.posterPath = "https://image.tmdb.org/t/p/original" + (dto.posterPath ?? "")
        self.releaseDate = dto.releaseDate?.toDateWithFormat("yyyy-MM-dd")
    }
}



