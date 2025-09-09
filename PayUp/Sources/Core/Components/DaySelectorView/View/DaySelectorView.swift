//
//  DaySelectorView.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 01/05/25.
//

import Foundation
import UIKit

final class DaySelectorView: UIView {
    
    private let viewModel = DaySelectorViewModel()
    private var buttons: [UIButton] = []
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
    
    private func setupView() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
            
        ])
    }
    
    private func setupButtons() {
        for (index, day) in viewModel.days.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(day, for: .normal)
            button.setTitleColor(Colors.textHeading, for: .normal)
            button.backgroundColor = Colors.backgroundTertiary
            button.titleLabel?.font = Fonts.titleExtraSmall()
            button.layer.cornerRadius = 6
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.clear.cgColor
            button.heightAnchor.constraint(equalToConstant: 32).isActive = true
            button.widthAnchor.constraint(equalToConstant: 48).isActive = true
            button.tag = index
            button.addTarget(self, action: #selector(dayTapped(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
    }
    
    @objc
    private func dayTapped(_ sender: UIButton) {
        updateSelection(index: sender.tag)
        viewModel.selectDay(at: sender.tag)
    }
    
    private func updateSelection(index: Int) {
        for (i, button) in buttons.enumerated() {
            let isSelected = (i == index)
            button.configuration?.baseForegroundColor = isSelected ?  Colors.accentBrand : Colors.textHeading
            button.layer.borderColor = isSelected ? Colors.accentBrand.cgColor : UIColor.clear.cgColor
            button.setTitleColor(isSelected ? Colors.accentBrand : Colors.textHeading, for: .normal)
        }
    }
    
    func getSelectedDay() -> Int? {
        return viewModel.getSelectedDay()
    }
    
    func selectDay(_ day: Int) {
        viewModel.selectDay(day)
        updateSelection(index: viewModel.selectedIndex)
    }

}
