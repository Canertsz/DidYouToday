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

final class HomeVC: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: HomeViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    @IBAction private func addDidYouButtonAction(_ sender: Any) {
        viewModel.addDidYouButtonTapped()
    }
}

// MARK: - HomeViewProtocol
extension HomeVC: HomeViewProtocol {
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(nibWithCellClass: RecordCell.self)
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
        
        tableView.rowHeight = 70
        tableView.estimatedRowHeight = 100
    }
    
    func reloadUI() {
        tableView.reloadData()
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
    
}

extension HomeVC: StoryboardInstantiable {
    static var storyboardName: String { "Home" }
    static var identifier: String { "HomeVC" }
}
