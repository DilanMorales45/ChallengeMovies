//
//  FavoritesLocalStorage.swift
//  ChallengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 13/12/24.
//

import Foundation

protocol FavoritesLocalStorageProtocol {
    func fetch() -> [MovieDTO]
}

struct FavoritesLocalStorageMock: FavoritesLocalStorageProtocol {
    func fetch() -> [MovieDTO] {
        Array(repeating: MovieDTO.mock, count: 6)
    }
}
