//
//  Cars.swift
//  ChallengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 28/11/24.
//

import Foundation

struct commonDetails {
    let nameMovie: String
    let rating: Double
    let urlImage: String
    private let releaseDate: Date?
    
    var releaseDateFullFormat: String {
        self.releaseDate?.toStringWithFormat("EEEE dd 'de' MMMM 'del' yyyy") ?? "Próximamente"
    }
    
    var releaseDateShortFormat: String {
        self.releaseDate?.toStringWithFormat("dd MMMM yyyy") ?? "Próximamente"
    }
    
    var info: String {
        "\(String(describing: self.releaseDate)) • \(self.nameMovie)"
    }
    
    init(nameMovie: String, rating: Double, urlImage: String, releaseDate: String) {
        self.nameMovie = nameMovie
        self.rating = rating
        self.urlImage = urlImage
        self.releaseDate = releaseDate.toDateWithFormat("dd/MM/YYYY")
    }
}


extension commonDetails {
    static var mock: commonDetails {
        commonDetails(nameMovie: "Terminator", rating: 7.45, urlImage: "", releaseDate: "10/02/2018")
    }
}
