//
//  CustomLabel.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import UIKit

enum LabelAppearence {
    case black
    case pink
}

final class CustomLabel: UILabel {
    init(appearence: LabelAppearence) {
        super.init(frame: .zero)
        setupBasics()
        updateAppearence(new: appearence)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Ext Basics
private extension CustomLabel {
    func setupBasics() {
        numberOfLines = 0
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.7
        textAlignment = .center
    }
}

// MARK: - Ext Appearence
private extension CustomLabel {
    func updateAppearence(new appearence: LabelAppearence) {
        switch appearence {
        case .black:
            textColor = .black
        case .pink:
            textColor = .systemPink
        }
    }
}
