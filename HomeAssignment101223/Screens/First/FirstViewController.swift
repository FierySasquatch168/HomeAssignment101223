//
//  FirstViewController.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import UIKit
import Combine

final class FirstViewController: UIViewController {
    private lazy var cancellables = Set<AnyCancellable>()
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let viewModel: ViewModelProtocol
    
    init(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        bind()
    }

    private func bind() {
        viewModel.locations
            .receive(on: DispatchQueue.main)
            .sink { [weak self] locations in
                self?.tableView.reloadData()
            }.store(in: &cancellables)
    }

}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locations.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseIdentifier,
                                                     for: indexPath) as? CustomTableViewCell
        else { return CustomTableViewCell() }
        cell.updateCell(location: viewModel.locations.value[indexPath.row], backgroundImageUrl: nil)
        return cell
    }
}

extension FirstViewController: UITableViewDelegate {
    
}

// MARK: - Ext Constraints
private extension FirstViewController {
    func setupConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
