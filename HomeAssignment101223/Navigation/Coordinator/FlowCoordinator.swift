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
    private let networkManager: LocationManager
    private let dataSource: TableDataSourceProtocol
    
    init(router: Routable,
         screenFactory: ScreenFactoryProtocol,
         dataManager: DataManagerProtocol,
         networkManager: LocationManager,
         dataSource: TableDataSourceProtocol) {
        self.router = router
        self.screenFactory = screenFactory
        self.dataManager = dataManager
        self.networkManager = networkManager
        self.dataSource = dataSource
    }
    
    func start() {
        showMainScreen()
    }
}

private extension FlowCoordinator {
    func showMainScreen() {
        var screen = screenFactory.createFirstScreen(dataManager: dataManager,
                                                     networkManager: networkManager,
                                                     dataSource: dataSource)
        let navController = screenFactory.createNavigationController(root: screen)
        
        screen.onPush = { [weak self] model in
            self?.showDetailScreen(model: model)
        }
        
        router.setupRootViewController(viewController: navController)
    }
    
    func showDetailScreen(model: LocationVisibleModel) {
        let secondScreen = screenFactory.createSecondScreen(model: model,
                                                            dataManager: dataManager)
        
        router.pushViewController(secondScreen, animated: true)
    }
}
