//
//  DataSourceManager.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import UIKit

enum Section {
    case main
}

protocol TableDataSourceProtocol {
    func createDataSource(for tableView: UITableView, with data: [LocationVisibleModel])
    func updateTableView(with data: [LocationVisibleModel])
}

final class DataSourceManager {
    typealias DataSource = UITableViewDiffableDataSource<Section, LocationVisibleModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, LocationVisibleModel>
    
    private var genericDataSource: DataSource?
}

extension DataSourceManager: TableDataSourceProtocol {
    func createDataSource(for tableView: UITableView, with data: [LocationVisibleModel]) {
        genericDataSource = DataSource(tableView: tableView, cellProvider: { [weak self] tableView, indexPath, itemIdentifier in
            return self?.locationCell(tableView, at: indexPath, with: itemIdentifier)
        })
        
        updateTableView(with: data)
    }
    
    func updateTableView(with data: [LocationVisibleModel]) {
        genericDataSource?.apply(createSnapshot(from: data), animatingDifferences: true)
    }
}

// MARK: - Cell
extension DataSourceManager {
    func locationCell(_ tableView: UITableView, at indexPath: IndexPath, with item: LocationVisibleModel) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CustomTableViewCell.reuseIdentifier,
                for: indexPath)
                as? CustomTableViewCell
        else { return CustomTableViewCell() }
        cell.viewModel = CellViewModel(cellModel: item)
        cell.selectionStyle = .none
        
        return cell
    }
}
// MARK: Snapshot
extension DataSourceManager {
    func createSnapshot(from data: [LocationVisibleModel]) -> Snapshot {
        var snapshot = NSDiffableDataSourceSnapshot<Section, LocationVisibleModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        return snapshot
    }
}
