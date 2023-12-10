//
//  SceneDelegate.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private lazy var screenFactory = ScreenFactory()
    private lazy var datastore = DataStore()
    private lazy var dataManager = DataManager(dataStore: datastore)
    private lazy var router: Routable = Router(routerDelegate: self)
    private lazy var networkService = BasicNetworkService()
    private lazy var networkManager = NetworkManager(networkService: networkService)
    private lazy var dataSource = DataSourceManager()
    private lazy var flowCoordinator = FlowCoordinator(router: router, screenFactory:
                                                        screenFactory, dataManager:
                                                        dataManager, 
                                                       networkManager: networkManager,
                                                       dataSource: dataSource)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        flowCoordinator.start()
    }
}

extension SceneDelegate: RouterDelegate {
    func setupRootViewController(_ viewController: Presentable?) {
        guard let viewController = viewController?.getVC() else { return }
        window?.rootViewController = viewController
    }
    
    func returnRootViewController() -> Presentable? {
        return window?.rootViewController
    }
}

