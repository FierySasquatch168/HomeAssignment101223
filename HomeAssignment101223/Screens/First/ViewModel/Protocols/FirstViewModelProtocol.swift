//
//  FirstViewModelProtocol.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import Foundation
import Combine

protocol LoadingViewModelProtocol {
    var requestResult: CurrentValueSubject<RequestResult?, Never> { get }
}

protocol ViewModelProtocol {
    var locations: CurrentValueSubject<[LocationVisibleModel], Never> { get }
}

protocol PagingProtocol {
    func updateNextPageIfNeeded(forRowAt indexPath: IndexPath?)
}
