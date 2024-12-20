//
//  FavoriteMovies+CoreDataProperties.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 19/12/24.
//
//

import Foundation
import CoreData

extension FavoriteMovies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovies> {
        return NSFetchRequest<FavoriteMovies>(entityName: "FavoriteMovies")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var idMovie: Int64
    @NSManaged public var favorite: Bool

    func convertToFavoriteMovies() -> FavoriteMovie {
        return FavoriteMovie(idMovie: self.idMovie, favorite: self.favorite, id: self.id!)
    }
}

extension FavoriteMovies : Identifiable {

}
