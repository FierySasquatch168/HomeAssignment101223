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
    func createFirstScreen(dataManager: DataManagerProtocol,
                           networkManager: LocationManager,
                           dataSource: TableDataSourceProtocol) -> Presentable & NavigationProtocol
    func createSecondScreen(model: LocationVisibleModel, dataManager: DataManagerProtocol) -> UIViewController
}

final class ScreenFactory: ScreenFactoryProtocol {
    func createNavigationController(root: Presentable) -> UIViewController {
        guard let vc = root.getVC() else { return UIViewController() }
        return UINavigationController(rootViewController: vc)
    }
    
    func createFirstScreen(dataManager: DataManagerProtocol,
                           networkManager: LocationManager,
                           dataSource: TableDataSourceProtocol) -> Presentable & NavigationProtocol {
        let viewModel = ViewModel(networkService: networkManager, dataManager: dataManager)
        return FirstViewController(viewModel: viewModel, dataSource: dataSource)
    }
    
    func createSecondScreen(model: LocationVisibleModel, dataManager: DataManagerProtocol) -> UIViewController {
        let detailViewModel = LocationViewModel(locationModel: model, dataManager: dataManager)
        let secondView = SecondViewContainer(locationViewModel: .constant(detailViewModel))
        return UIHostingController(rootView: secondView)
    }
}
