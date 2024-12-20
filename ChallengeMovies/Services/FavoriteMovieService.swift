//
//  FavoriteMovieService.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 19/12/24.
//

import Foundation
import CoreData

class FavoriteMovieService {
    
    private let repository: FavoriteMoviesRepository
    
    init(repository: FavoriteMoviesRepository) {
        self.repository = repository
    }
    
    func create(favoriteMovie: FavoriteMovie) {
        self.repository.create(favoriteMovie: favoriteMovie)
    }
    
    func getAll() -> [FavoriteMovie]? {
        self.repository.getAll()
    }
    
    func get(byIdentifier id: Int64) -> FavoriteMovie? {
        self.repository.get(byIdentifier: id)
    }
    
    func delete(record: FavoriteMovie) -> Bool {
        self.repository.delete(record: record)
    }
}
