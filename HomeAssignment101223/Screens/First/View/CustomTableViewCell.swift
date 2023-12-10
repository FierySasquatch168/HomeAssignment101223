//
//  CustomTableViewCell.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import UIKit
import Combine

final class CustomTableViewCell: UITableViewCell {
    private lazy var cancellables = Set<AnyCancellable>()
    
    private var cellState: CellStateEnum? {
        didSet {
            cityNameLabel.updateColor(new: cellState?.stateObject.textColor)
            cityNameInEnglishLabel.updateColor(new: cellState?.stateObject.textColor)
            regionLabel.updateColor(new: cellState?.stateObject.textColor)
            backgroundColor = cellState?.stateObject.backgroundColor
        }
    }
    
    var viewModel: CellViewModel? {
        didSet {
            viewModel?.$cellModel
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { [weak self] model in
                    self?.updateCell(location: model)
                }).store(in: &cancellables)
        }
    }
    
    private lazy var cityNameLabel = CustomLabel(textColor: cellState?.stateObject.textColor)
    private lazy var cityNameInEnglishLabel = CustomLabel(textColor: cellState?.stateObject.textColor)
    private lazy var regionLabel = CustomLabel(textColor: cellState?.stateObject.textColor)
    
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
    
    private func updateCell(location: LocationVisibleModel) {
        updateLabels(location: location)
        updateBackground(backgroundImageUrl: location.imageURL)
        updateCellState(model: location)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.viewModel = nil
        self.cellState = nil
        self.backgroundImageView.image = nil
    }
}

// MARK: - Ext UI
private extension CustomTableViewCell {
    func updateLabels(location: LocationVisibleModel) {
        cityNameLabel.text = location.hebrewName
        cityNameInEnglishLabel.text = location.englishName
        regionLabel.text = location.region
    }
    
    func updateBackground(backgroundImageUrl: URL?) {
        backgroundImageView.setImage(from: backgroundImageUrl)
    }
    
    func updateCellState(model: LocationVisibleModel) {
        if model.isLiked && model.imageURL == nil {
            cellState = .likedWithoutBackground
        } else if model.isLiked && model.imageURL != nil {
            cellState = .likedWithBackground
        } else {
            cellState = .ordinary
        }
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

