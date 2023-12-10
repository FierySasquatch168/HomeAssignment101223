//
//  CustomTableViewCell.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import UIKit
import Combine

final class CustomTableViewCell: UITableViewCell {
    var viewModel: CellViewModel? {
        didSet {
            guard let viewModel else { return }
            updateCellBasics(location: viewModel.cellModel)
            updateColors(cellState: viewModel.cellState)
        }
    }
    
    private lazy var cityNameLabel = CustomLabel(textColor: viewModel?.cellState?.stateObject.textColor)
    private lazy var cityNameInEnglishLabel = CustomLabel(textColor: viewModel?.cellState?.stateObject.textColor)
    private lazy var regionLabel = CustomLabel(textColor: viewModel?.cellState?.stateObject.textColor)
    private lazy var backgroundImageView = CustomBackgroundImageView(frame: .zero)
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.viewModel = nil
        self.backgroundImageView.image = nil
    }
}

// MARK: - Ext UI Basic
private extension CustomTableViewCell {
    private func updateCellBasics(location: LocationVisibleModel) {
        updateLabels(location: location)
        updateBackground(backgroundImageUrl: location.imageURL)
    }
    
    func updateLabels(location: LocationVisibleModel) {
        cityNameLabel.text = location.hebrewName
        cityNameInEnglishLabel.text = location.englishName
        regionLabel.text = location.region
    }
    
    func updateBackground(backgroundImageUrl: URL?) {
        backgroundImageView.setImage(from: backgroundImageUrl)
    }
}

// MARK: - Ext UI State
private extension CustomTableViewCell {
    func updateColors(cellState: CellStateEnum?) {
        mainStackView.arrangedSubviews
            .compactMap({ $0 as? CustomLabel })
            .forEach({ $0.updateColor(new: cellState?.stateObject.textColor) })
        backgroundColor = cellState?.stateObject.backgroundColor
    }
}

// MARK: - Ext constraints
extension CustomTableViewCell {
    func setupConstraints() {
        setupBackground()
        setupManStack()
    }
    
    func setupManStack() {
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func setupBackground() {
        addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.frame = bounds
    }
}

