//
//  CalendarView.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 7.03.2025.
//

import UIKit

protocol CalendarViewProtocol: AnyObject {
    func updateCalendar()
}

final class CalendarView: UIView {
    var viewModel: CalendarViewViewModelProtocol? {
        didSet {
            setupCalendar()
        }
    }
    
    private lazy var calendarView: UICalendarView = {
        let calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.calendar = Calendar.current
        calendarView.locale = Locale.current
        calendarView.fontDesign = .rounded
        calendarView.backgroundColor = .systemBackground
        
        calendarView.availableDateRange = DateInterval(start: .distantPast, end: .distantFuture)
        
        calendarView.visibleDateComponents = Calendar.current.dateComponents([.year, .month], from: Date())
        
        return calendarView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(scrollView)
        scrollView.addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            calendarView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            calendarView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupCalendar() {
        guard let viewModel else { return }
        
        let dateSelection = UICalendarSelectionSingleDate(delegate: nil)
        calendarView.selectionBehavior = dateSelection
        
        let decoration = CheckedDatesDecorationHandler(viewModel: viewModel)
        calendarView.delegate = decoration
        
        self.decoration = decoration
        
        updateCalendar()
    }
    
    private var decoration: CheckedDatesDecorationHandler?
    
    func updateCalendar() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            let calendar = Calendar.current
            let currentDate = Date()
            let currentDateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)

            self.calendarView.reloadDecorations(forDateComponents: [currentDateComponents], animated: true)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let calendarSize = calendarView.sizeThatFits(CGSize(width: bounds.width, height: .greatestFiniteMagnitude))
        scrollView.contentSize = CGSize(width: bounds.width, height: max(calendarSize.height, bounds.height))
    }
}

// MARK: - Decoration Handler for checked dates
class CheckedDatesDecorationHandler: NSObject, UICalendarViewDelegate {
    private let viewModel: CalendarViewViewModelProtocol
    
    init(viewModel: CalendarViewViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        guard let date = dateComponents.date else { return nil }
        
        let isChecked = viewModel.dateIsChecked(date)
        if isChecked {
            return .customView {
                let imageView = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
                imageView.tintColor = .systemGreen
                return imageView
            }
        }
        
        return nil
    }
}
