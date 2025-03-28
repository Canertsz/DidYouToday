//
//  ViewController.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 28.02.2025.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func setupUI()
    func reloadUI()
}

extension HomeVC {
    enum constants {
        static let rowHeight = 70.0
    }
}

final class HomeVC: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let emptyStateView = EmptyStateView()
    
    var viewModel: HomeViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEmptyStateView()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.refreshData()
    }

    private func setupEmptyStateView() {
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyStateView)
        
        NSLayoutConstraint.activate([
            emptyStateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        emptyStateView.isHidden = true
    }
    
    private func updateEmptyStateVisibility() {
        let hasRecords = viewModel.numberOfItemsInSection > 0
        emptyStateView.isHidden = hasRecords
        tableView.isHidden = !hasRecords
    }

    @IBAction private func addDidYouButtonAction(_ sender: Any) {
        viewModel.addDidYouButtonTapped()
    }
    
    func navigateToRecordDetail(_ record: DidYou) {
        viewModel.navigateToRecordDetail(record)
    }
}

// MARK: - HomeViewProtocol
extension HomeVC: HomeViewProtocol {
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
        tableView.rowHeight = constants.rowHeight
        
        tableView.register(nibWithCellClass: RecordCell.self)
    }
    
    func reloadUI() {
        tableView.reloadData()
        updateEmptyStateVisibility()
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(RecordCell.self, indexPath: indexPath)
        
        guard let record = viewModel.record(for: indexPath) else { return cell }
        let vm = RecordCellVM(record: record)
        cell.viewModel = vm
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRecord(at: indexPath)
    }
}

extension HomeVC: StoryboardInstantiable {
    static var storyboardName: String { "Home" }
    static var identifier: String { "HomeVC" }
}
