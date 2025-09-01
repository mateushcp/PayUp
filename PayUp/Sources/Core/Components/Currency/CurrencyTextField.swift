//
//  CurrencyTextField.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 29/06/25.
//

import UIKit

final class CurrencyTextField: UIView {
    private let titleLabel = UILabel()
    private let textField = UITextField()
    
    private let currencyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("BRL ▾", for: .normal)
        button.titleLabel?.font = Fonts.paragraphMedium()
        button.setTitleColor(Colors.textLabel, for: .normal)
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
        textField.rightView = currencyButton
        textField.rightViewMode = .always
        
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
    
    func getText() -> String? {
        return textField.text
    }
    
    func setText(_ v: String) {
        textField.text = v
    }
    
    func getValue() -> Double {
        guard let text = textField.text else { return 0.0 }
        
        let cleanText = text.replacingOccurrences(of: "R$", with: "")
            .replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: ",", with: ".")
            .replacingOccurrences(of: " ", with: "")
        
        return Double(cleanText) ?? 0.0
        
    }
}
