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
    func didSelectRecord(at indexPath: IndexPath)
    func refreshData()
    func navigateToRecordDetail(_ record: DidYou)
    var numberOfItemsInSection: Int { get }
}

protocol NotificationCenterProtocol {
    func addObserver(_ observer: Any, selector: Selector, name: NSNotification.Name?, object: Any?)
    func removeObserver(_ observer: Any)
    func post(name: NSNotification.Name, object: Any?)
}

// Extension to make NotificationCenter conform to our protocol
extension NotificationCenter: NotificationCenterProtocol {}

final class HomeVM {
    private weak var view: HomeViewProtocol?
    private let coordinator: HomeCoordinatorProtocol
    private var records: [DidYou] = []
    private let coreDataService: CoreDataServiceProtocol
    private let notificationCenter: NotificationCenterProtocol
    
    init(
        view: HomeViewProtocol,
        coordinator: HomeCoordinatorProtocol,
        coreDataService: CoreDataServiceProtocol = CoreDataService.shared,
        notificationCenter: NotificationCenterProtocol = NotificationCenter.default
    ) {
        self.view = view
        self.coordinator = coordinator
        self.coreDataService = coreDataService
        self.notificationCenter = notificationCenter
    }
    
    deinit {
        // Remove self as an observer for all notifications
        // This ensures we don't have any retain cycles
        notificationCenter.removeObserver(self)
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
    
    func didSelectRecord(at indexPath: IndexPath) {
        guard let record = records[safe: indexPath.row] else { return }
        coordinator.navigateToRecordDetailScreen(record: record)
    }
    
    func refreshData() {
        fetchRecords()
        view?.reloadUI()
    }
    
    func navigateToRecordDetail(_ record: DidYou) {
        coordinator.navigateToRecordDetailScreen(record: record)
    }
}

//MARK: - FetchRecords
extension HomeVM {
    func fetchRecords() {
        coreDataService.fetchCoreData { [weak self] records in
            guard let self, let records else { return }
            self.records = records
            
            DispatchQueue.main.async {
                self.view?.reloadUI()
            }
        }
    }
}

//MARK: - NotificationCenter
extension HomeVM {
    func registerNotificationCenterObserver() {
        notificationCenter.addObserver(
            self,
            selector: #selector(handleRecordCreation),
            name: .didFinishCreatingRecord,
            object: nil
        )
    }

    // Making this internal for testing purposes
    @objc internal func handleRecordCreation() {
        refreshData()
    }
}
