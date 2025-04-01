//
//  RecordDetailVC.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 28.02.2025.
//

import UIKit

protocol RecordDetailViewProtocol: AnyObject {
    func setupUI()
    func setupCalendar(with viewModel: CalendarViewViewModelProtocol)
    func updateCalendar()
}

final class RecordDetailVC: UIViewController {
    
    var viewModel: RecordDetailViewModelProtocol!
    
    @IBOutlet weak var activityNameLabel: UILabel!
    @IBOutlet weak var answerButton: UIButton!
    @IBOutlet weak var pastRecordsCalendar: CalendarView!
    @IBOutlet weak var editActivityButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Refresh UI when returning from edit screen
        viewModel.refreshData()
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        viewModel.answerButtonTapped()
    }
    
    @IBAction func editActivityButtonTapped(_ sender: UIButton) {
        viewModel.editActivityButtonTapped()
    }
}

// MARK: - RecordDetailViewProtocol
extension RecordDetailVC: RecordDetailViewProtocol {
    func setupUI() {
        activityNameLabel.text = viewModel.activityName
        
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.title = viewModel.buttonText
        buttonConfig.baseBackgroundColor = viewModel.buttonColor
        buttonConfig.cornerStyle = .medium
        
        answerButton.configuration = buttonConfig
        
        answerButton.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)
    }
    
    func setupCalendar(with viewModel: CalendarViewViewModelProtocol) {
        pastRecordsCalendar.viewModel = viewModel
    }
    
    func updateCalendar() {
        pastRecordsCalendar.updateCalendar()
    }
}

extension RecordDetailVC: StoryboardInstantiable {
    static var storyboardName: String { "RecordDetail" }
    static var identifier: String { "RecordDetailVC" }
}
