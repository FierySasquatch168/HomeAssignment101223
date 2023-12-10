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
    func createFirstScreen(dataManager: DataManagerProtocol) -> Presentable & NavigationProtocol
    func createSecondScreen(model: LocationVisibleModel, dataManager: DataManagerProtocol) -> UIViewController
}

final class ScreenFactory: ScreenFactoryProtocol {
    func createNavigationController(root: Presentable) -> UIViewController {
        guard let vc = root.getVC() else { return UIViewController() }
        return UINavigationController(rootViewController: vc)
    }
    
    func createFirstScreen(dataManager: DataManagerProtocol) -> Presentable & NavigationProtocol {
        let networkService = BasicNetworkService()
        let networkManager = NetworkManager(networkService: networkService)
        let viewModel = ViewModel(networkService: networkManager, dataManager: dataManager)
        return FirstViewController(viewModel: viewModel)
    }
    
    func createSecondScreen(model: LocationVisibleModel, dataManager: DataManagerProtocol) -> UIViewController {
        let detailViewModel = LocationViewModel(locationModel: model, dataManager: dataManager)
        let secondView = SecondViewContainer(locationViewModel: .constant(detailViewModel))
        return UIHostingController(rootView: secondView)
    }
}
