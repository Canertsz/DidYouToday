//
//  HomeVM.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 28.02.2025.
//

import Foundation

protocol HomeViewModelProtocol {
    func viewDidLoad()
    func addDidYouButtonTapped()
    func record(for indexPath: IndexPath) -> DidYou?
    var numberOfItemsInSection: Int { get }
}

final class HomeVM {
    private weak var view: HomeViewProtocol?
    private let coordinator: HomeCoordinatorProtocol
    private var records: [DidYou] = []
    
    init(view: HomeViewProtocol, coordinator: HomeCoordinatorProtocol) {
        self.view = view
        self.coordinator = coordinator
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - HomeViewModelProtocol
extension HomeVM: HomeViewModelProtocol {
    var numberOfItemsInSection: Int {
        return records.count
    }
    
    func viewDidLoad() {
        view?.setupUI()
        fetchRecords()
        registerNotificationCenterObserver()
        
    }

    func addDidYouButtonTapped() {
        coordinator.navigateToAddDidYouScreen()
    }
    
    func record(for indexPath: IndexPath) -> DidYou? { records[safe: indexPath.row] }
}

//MARK: - FetchRecords
extension HomeVM {
    func fetchRecords() {
        CoreDataService.fetchCoreData { [weak self] records in
            guard let records else { return }
            self?.records = records
        }
    }
}

//MARK: - NotificationCenter
extension HomeVM {
    func registerNotificationCenterObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleRecordCreation),
            name: .didFinishCreatingRecord,
            object: nil
        )
    }

    @objc private func handleRecordCreation() {
        fetchRecords()
        view?.reloadUI()
    }
}
