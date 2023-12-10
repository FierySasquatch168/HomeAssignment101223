//
//  CustomTableViewCell.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    private lazy var cityNameLabel = CustomLabel()
    private lazy var cityNameInEnglishLabel = CustomLabel()
    private lazy var regionLabel = CustomLabel()
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cityNameLabel, cityNameInEnglishLabel, regionLabel])
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(location: Location, backgroundImageUrl: URL?) {
        updateLabels(location: location)
        updateBackground(backgroundImageUrl: backgroundImageUrl)
    }
}

// MARK: - Ext UI
private extension CustomTableViewCell {
    func updateLabels(location: Location) {
        cityNameLabel.text = location.hebrewName
        cityNameInEnglishLabel.text = location.englishName
        regionLabel.text = location.region
    }
    
    func updateBackground(backgroundImageUrl: URL?) {
        backgroundImageView.setImage(from: backgroundImageUrl)
    }
}

// MARK: - Ext constraints
extension CustomTableViewCell {
    func setupConstraints() {
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

