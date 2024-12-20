//
//  FavoriteMoviesRepository.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 19/12/24.
//

import Foundation

protocol FavoriteMoviesRepository {
    func create(favoriteMovie: FavoriteMovie)
    func getAll() -> [FavoriteMovie]?
    func get(byIdentifier id: Int64) -> FavoriteMovie?
    func delete(record: FavoriteMovie) -> Bool
}
