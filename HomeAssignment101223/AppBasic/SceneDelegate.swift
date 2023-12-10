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

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        window?.rootViewController = screenFactory.createFirstScreen()
        window?.makeKeyAndVisible()
    }
}

protocol ScreenFactoryProtocol {
    func createFirstScreen() -> UIViewController
//    func createSecondScreen() -> UIViewController
}

final class ScreenFactory: ScreenFactoryProtocol {
    func createFirstScreen() -> UIViewController {
        let networkService = BasicNetworkService()
        let networkManager = NetworkManager(networkService: networkService)
        let viewModel = ViewModel(networkService: networkManager)
        let viewController = FirstViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: viewController)
    }
    
//    func createSecondScreen() -> UIViewController {
//        
//    }
}

