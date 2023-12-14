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

final class FirstViewController: UIViewController, NavigationProtocol, LoadingViewControllerProtocol {
    var onPush: ((LocationVisibleModel) -> Void)?
    
    private lazy var cancellables = Set<AnyCancellable>()
    
    private lazy var tableView = CustomTableView(delegate: self)
    lazy var loadingView = CustomAnimatedView(frame: .zero)
    
    private let viewModel: ViewModelProtocol & PagingProtocol & LoadingViewModelProtocol
    private let dataSource: TableDataSourceProtocol
    // MARK: Init
    init(viewModel: ViewModelProtocol & PagingProtocol & LoadingViewModelProtocol,
         dataSource: TableDataSourceProtocol) {
        self.viewModel = viewModel
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        dataSource.createDataSource(for: tableView, with: viewModel.locations.value)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cancellables.forEach({ $0.cancel() })
        cancellables.removeAll()
    }
}

// MARK: - Ext Bind
private extension FirstViewController {
    func bind() {
        viewModel.locations
            .receive(on: DispatchQueue.main)
            .sink { [weak self] locations in
                self?.dataSource.updateTableView(with: locations)
            }.store(in: &cancellables)
        
        viewModel.requestResult
            .receive(on: DispatchQueue.main)
            .sink { [weak self] requestResult in
                self?.loadingView.toggleAnimationVisibility(for: requestResult)
            }.store(in: &cancellables)
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
        setupLoadingView()
        setupTableView()
    }
    
    func setupTableView() {
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
