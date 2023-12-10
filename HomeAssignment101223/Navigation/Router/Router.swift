//
//  Router.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import UIKit

protocol Routable: AnyObject {
    func setupRootViewController(viewController: Presentable)
    func pushViewController(_ viewController: Presentable?, animated: Bool)
}

final class Router {
    weak var delegate: RouterDelegate?
    private var currentViewController: Presentable?
    
    init(routerDelegate: RouterDelegate) {
        delegate = routerDelegate
    }
}

extension Router: Routable {
    func setupRootViewController(viewController: Presentable) {
        currentViewController = viewController
        delegate?.setupRootViewController(currentViewController)
    }
    
    func pushViewController(_ viewController: Presentable?, animated: Bool) {
        guard
            let vc = viewController?.getVC(),
            let navController = currentViewController as? UINavigationController
        else { return }
        setCurrentViewController(navController)
        navController.pushViewController(vc, animated: animated)
    }
    
}

// MARK: - Ext Current VC
private extension Router {
    func setCurrentViewController(_ viewController: Presentable?) {
        guard let viewController else { return }
        currentViewController = viewController
    }
}
