//
//  dayselector.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 01/05/25.
//

import Foundation
// DaySelectorView.swift
import UIKit

import Foundation

final class DaySelectorViewModel {
    let days = ["SEG", "TER", "QUA", "QUI", "SEX", "SAB", "DOM"]
    private let calendar = Calendar.current

    var selectedIndex: Int {
        let weekday = calendar.component(.weekday, from: Date())
        // Calendar weekday: 1 = Sunday, 2 = Monday, ..., 7 = Saturday
        return (weekday + 5) % 7 // convert to index: 0 = SEG (Mon)
    }

    var onDaySelected: ((Int) -> Void)?
    
    func selectDay(at index: Int) {
        onDaySelected?(index)
    }
}

// DaySelectorView.swift
import UIKit

final class DaySelectorView: UIView {

    private let viewModel = DaySelectorViewModel()
    private var buttons: [UIButton] = []

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupButtons()
        updateSelection(index: viewModel.selectedIndex)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButtons() {
        for (index, day) in viewModel.days.enumerated() {
            var configuration = UIButton.Configuration.filled()
            configuration.title = day
            configuration.baseBackgroundColor = Colors.backgroundTertiary
            configuration.baseForegroundColor = Colors.textHeading
            configuration.cornerStyle = .fixed
            configuration.contentInsets = .zero

            let button = UIButton(configuration: configuration, primaryAction: nil)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.cornerRadius = 6
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.clear.cgColor
            button.titleLabel?.font = Fonts.paragraphMedium()
            button.widthAnchor.constraint(equalToConstant: 48).isActive = true
            button.heightAnchor.constraint(equalToConstant: 32).isActive = true
            button.tag = index
            button.addTarget(self, action: #selector(dayTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
    }

    @objc private func dayTapped(_ sender: UIButton) {
        updateSelection(index: sender.tag)
        viewModel.selectDay(at: sender.tag)
    }

    private func updateSelection(index: Int) {
        for (i, button) in buttons.enumerated() {
            let isSelected = (i == index)
            button.configuration?.baseForegroundColor = isSelected ? Colors.accentBrand : Colors.textHeading
            button.layer.borderColor = isSelected ? Colors.accentBrand.cgColor : UIColor.clear.cgColor
        }
    }

    private func setupView() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
}
