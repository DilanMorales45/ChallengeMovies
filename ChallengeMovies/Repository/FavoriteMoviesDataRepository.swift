//
//  FavoriteMoviesDataRepository.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 19/12/24.
//

import Foundation
import CoreData

class FavoriteMoviesDataRepository: FavoriteMoviesRepository {
    
    func create(favoriteMovie: FavoriteMovie) {
        let favoriteMovies = FavoriteMovies(context: PersistentStorage.shared.context)
        favoriteMovies.favorite = favoriteMovie.favorite
        favoriteMovies.idMovie = favoriteMovie.idMovie
        favoriteMovies.id = favoriteMovie.id
        
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [FavoriteMovie]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: FavoriteMovies.self)
        
        var favorites: [FavoriteMovie] = []
        
        result?.forEach({ (favoriteMovies) in
            favorites.append(favoriteMovies.convertToFavoriteMovies())
        })
        
        return favorites
    }
    
    func get(byIdentifier id: Int64) -> FavoriteMovie? {
        let result = getFavoriteMovies(byIdentifier: id)
        guard result != nil else {return nil}
        return result?.convertToFavoriteMovies()
        
    }
    
    func delete(record: FavoriteMovie) -> Bool {
        let favoriteMovies = getFavoriteMovies(byIdentifier: record.idMovie)
        guard favoriteMovies != nil else { return false}
        
        PersistentStorage.shared.context.delete(favoriteMovies!)
        PersistentStorage.shared.saveContext() 
        return true
    }
    
    private func getFavoriteMovies(byIdentifier id: Int64) -> FavoriteMovies? {
        let fetchRequest = NSFetchRequest<FavoriteMovies>(entityName: "FavoriteMovies")
        let predicate = NSPredicate(format: "idMovie==%@", id as CVarArg)
        
        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            
            guard result != nil else {return nil}
            
            return result
        } catch let error {
            debugPrint(error)
            return nil
        }
    }
   
}
