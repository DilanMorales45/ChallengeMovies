//
//  RootCoordinator.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 18/11/24.
//

import Foundation
import UIKit

final class RootCoordinator: NSObject, Coordinator, ParentCoordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
//    var baseTabBarController: BaseTabBarController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
//        baseTabBarController = BaseTabBarController(coordinator: self)
//        baseTabBarController!.coordinator = self
//        navigationController.pushViewController(baseTabBarController!, animated: animated)
    }
    
    func cleanUpMerch() {
//        baseTabBarController?.cleanUpMerch()
    }
}
