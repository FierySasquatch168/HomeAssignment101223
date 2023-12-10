//
//  Ext UIIMageView.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import UIKit
import Kingfisher


extension UIImageView {
    func setImage(from url: URL?) {
        guard let url else { return }
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, options: [.cacheSerializer(FormatIndicatedCacheSerializer.png)]) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(_):
                self.kf.indicatorType = .none
            case .failure(_):
                self.kf.indicatorType = .none
                image = UIImage(systemName: "xmark")
            }
        }
    }
}
