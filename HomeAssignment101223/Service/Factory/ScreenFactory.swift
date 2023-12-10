//
//  ScreenFactory.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import UIKit
import SwiftUI

protocol ScreenFactoryProtocol {
    func createNavigationController(root: Presentable) -> UIViewController
    func createFirstScreen() -> Presentable & NavigationProtocol
    func createSecondScreen(model: LocationVisibleModel) -> UIViewController
}

final class ScreenFactory: ScreenFactoryProtocol {
    func createNavigationController(root: Presentable) -> UIViewController {
        guard let vc = root.getVC() else { return UIViewController() }
        return UINavigationController(rootViewController: vc)
    }
    
    func createFirstScreen() -> Presentable & NavigationProtocol {
        let networkService = BasicNetworkService()
        let networkManager = NetworkManager(networkService: networkService)
        let viewModel = ViewModel(networkService: networkManager)
        return FirstViewController(viewModel: viewModel)
    }
    
    func createSecondScreen(model: LocationVisibleModel) -> UIViewController {
        let detailViewModel = LocationViewModel(locationModel: model)
        let secondView = SecondViewContainer(locationViewModel: .constant(detailViewModel))
        return UIHostingController(rootView: secondView)
    }
}
