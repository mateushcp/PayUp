//
//  ClinetFormView.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 29/06/25.
//

import UIKit

final class ClientFormView: UIView {
    private let mode: ClientFormMode
    weak var delegate: ClientFormViewDelegate?
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.backgroundPrimary
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Adicionar cliente"
//        label.text = mode == .add ? "Adicionar cliente" : "Editar cliente"
        label.font = Fonts.titleSmall()
        label.textColor = .white
        return label
    }()
    
    private lazy var valueField = CurrencyTextField(title: "Valor", placeholder: "R$ 0,00")
    private lazy var dateField = DatePickerTextField(title: "Data de cobrança", placeholder: "DD/MM/AAAA")
    
    init(mode: ClientFormMode) {
        self.mode = mode
        super.init(frame: .zero)
        backgroundColor = Colors.backgroundPrimary
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9)
            
        ])
        
        setupStack()
    }
    
    private func setupStack() {
        let formStack = UIStackView(arrangedSubviews: [
            titleLabel,
            valueField,
            dateField
        ])
        
        formStack.axis = .vertical
        formStack.spacing = 16
        formStack.isLayoutMarginsRelativeArrangement = true
        formStack.layoutMargins = UIEdgeInsets(top: 12, left: 24, bottom: 24, right: 24)
        formStack.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(formStack)
        NSLayoutConstraint.activate([
            formStack.topAnchor.constraint(equalTo: containerView.topAnchor),
            formStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            formStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            formStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
}
