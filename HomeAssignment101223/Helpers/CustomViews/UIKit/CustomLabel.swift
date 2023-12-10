//
//  CustomLabel.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import UIKit

final class CustomLabel: UILabel {

    init(textColor: UIColor?) {
        super.init(frame: .zero)
        setupBasics()
        updateColor(new: textColor)
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
extension CustomLabel {
    func updateColor(new color: UIColor?) {
       textColor = color
    }
}
