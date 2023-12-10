//
//  FlowCoordinator.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    func start()
}

final class FlowCoordinator: CoordinatorProtocol {
    
    private let router: Routable
    private let screenFactory: ScreenFactoryProtocol
    private let dataManager: DataManagerProtocol
    
    init(router: Routable,
         screenFactory: ScreenFactoryProtocol,
         dataManager: DataManagerProtocol) {
        self.router = router
        self.screenFactory = screenFactory
        self.dataManager = dataManager
    }
    
    func start() {
        showMainScreen()
    }
}

private extension FlowCoordinator {
    func showMainScreen() {
        var screen = screenFactory.createFirstScreen(dataManager: dataManager)
        let navController = screenFactory.createNavigationController(root: screen)
        
        screen.onPush = { [weak self] model in
            self?.showDetailScreen(model: model)
        }
        
        router.setupRootViewController(viewController: navController)
    }
    
    func showDetailScreen(model: LocationVisibleModel) {
        let secondScreen = screenFactory.createSecondScreen(model: model)
        
        router.pushViewController(secondScreen, animated: true)
    }
}
