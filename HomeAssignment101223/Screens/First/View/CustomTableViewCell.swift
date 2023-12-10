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
    
    var viewModel: CellViewModel? {
        didSet {
            viewModel?.$cellModel
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { [weak self] model in
                    self?.updateCell(location: model)
                }).store(in: &cancellables)
        }
    }
    
    private lazy var cityNameLabel = CustomLabel(appearence: .black)
    private lazy var cityNameInEnglishLabel = CustomLabel(appearence: .black)
    private lazy var regionLabel = CustomLabel(appearence: .black)
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
        updateColors(location: location)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.viewModel = nil
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
        DispatchQueue.main.async { [weak self] in
            self?.backgroundImageView.setImage(from: backgroundImageUrl)
        }
    }
    
    func updateColors(location: LocationVisibleModel) {
        updateLabels(model: location)
        updateBackground(model: location)
    }
    
    func updateLabels(model: LocationVisibleModel) {
        let appearence: LabelAppearence = model.isLiked && model.imageURL == nil ? .pink : .black
        mainStackView.arrangedSubviews
            .compactMap({ $0 as? CustomLabel})
            .forEach({ $0.updateAppearence(new: appearence) })
    }
    
    func updateBackground(model: LocationVisibleModel) {
        backgroundColor = model.isLiked && model.imageURL == nil ? .systemPink : .clear
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

