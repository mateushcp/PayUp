//
//  DatePickerTextField.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 29/06/25.
//

import UIKit

final class DatePickerTextField: UIView {
    private let titleLabel = UILabel()
    private let textField = UITextField()
    
    private let calendarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "calendar"), for: .normal)
        button.tintColor = Colors.textLabel
        button.widthAnchor.constraint(equalToConstant: 24).isActive = true
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        titleLabel.font = Fonts.titleSmall()
        titleLabel.textColor = Colors.textHeading
        
        textField.backgroundColor = Colors.backgroundTertiary
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Colors.borderPrimary.cgColor
        textField.font = Fonts.paragraphMedium()
        textField.textColor = Colors.textLabel
        textField.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                             attributes: [.foregroundColor: Colors.textPlaceholder])
        textField.setLeftPaddingPoints(12)
        textField.rightView = calendarButton
        textField.rightViewMode = .always
        
        calendarButton.addAction(.init(handler: {
            [weak self] _ in
            self?.presentDataPicker()
        }), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, textField])
        stack.axis = .vertical
        stack.spacing = 4
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textField.heightAnchor.constraint(equalToConstant: 43),
            textField.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func presentDataPicker() {
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n",
                                     message: nil,
                                     preferredStyle: .actionSheet)
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        alert.view.addSubview(picker)
        NSLayoutConstraint.activate([
            picker.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 8),
            picker.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -8),
            picker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 8),
            picker.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        alert.addAction(.init(title: "Ok", style: .default) { _ in
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd/MM/yyyy"
            self.textField.text = dateFormater.string(from: picker.date)
        })
        
        alert.addAction(.init(title: "Cancelar", style: .cancel))
        
        if let viewController = self.parentViewController() {
            viewController.present(alert, animated: true)
        }
    }
    
    func setText(_ text: String) {
        self.textField.text = text
    }
    
    func getText() -> String? {
        return self.textField.text
    }
    
}
