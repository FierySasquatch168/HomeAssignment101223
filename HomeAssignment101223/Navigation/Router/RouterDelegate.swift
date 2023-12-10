//
//  RouterDelegate.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import UIKit

protocol RouterDelegate: AnyObject {
    func setupRootViewController(_ viewController: Presentable?)
}
