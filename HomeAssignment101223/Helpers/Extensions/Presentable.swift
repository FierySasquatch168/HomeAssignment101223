//
//  Presentable.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import UIKit

protocol Presentable: AnyObject {
    func getVC() -> UIViewController?
}

extension UIViewController: Presentable {
    func getVC() -> UIViewController? {
        return self
    }
}
