//
//  FirstViewController.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import UIKit
import Combine

protocol NavigationProtocol {
    var onPush: ((LocationVisibleModel) -> Void)? { get set }
}

final class FirstViewController: UIViewController, NavigationProtocol {
    var onPush: ((LocationVisibleModel) -> Void)?
    
    private lazy var cancellables = Set<AnyCancellable>()
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let viewModel: ViewModelProtocol & PagingProtocol
    
    init(viewModel: ViewModelProtocol & PagingProtocol) {
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

// MARK: - Ext UITableViewDataSource
extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locations.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseIdentifier,
                                                     for: indexPath) as? CustomTableViewCell
        else { return CustomTableViewCell() }
        cell.updateCell(location: viewModel.locations.value[indexPath.row])
        return cell
    }
}

// MARK: - Ext UITableViewDelegate
extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.updateNextPageIfNeeded(forRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLocation = viewModel.locations.value[indexPath.row]
        onPush?(selectedLocation)
    }
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
