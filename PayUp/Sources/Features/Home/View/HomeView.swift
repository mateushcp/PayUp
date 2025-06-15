//
//  HomeView.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 01/05/25.
//

import UIKit

final class HomeView: UIView {
    
    // MARK: - Scroll + Container
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private let contentView: UIView = {
        let view = UIView()
        view.layoutMargins = UIEdgeInsets(top: 16, left: 24, bottom: 24, right: 24)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var headerStack: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [
            logoImage, spacer, bellButton, profileImage
        ])
        stackView.setCustomSpacing(24, after: bellButton)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Subviews
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mainLogo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 82),
            imageView.heightAnchor.constraint(equalToConstant: 24),
        ])
        return imageView
    }()
    
    private let bellButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "bell"), for: .normal)
        button.tintColor = Colors.textHeading
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 24),
            button.heightAnchor.constraint(equalToConstant: 24),
        ])
        return button
    }()
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profileImage"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 44),
            imageView.heightAnchor.constraint(equalToConstant: 44)
        ])
        return imageView
    }()
    
    private let daySelectorView: DaySelectorView = {
        let view = DaySelectorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 32)
        ])
        return view
    }()
    
    private let todayLabel: UILabel = {
        let label = UILabel()
        label.text = "Hoje"
        label.font = Fonts.titleSmall()
        label.textColor = Colors.textHeading
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var todayStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            todayLabel, paymentCardView
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let paymentCardView: PaymentCardView = {
        let card = PaymentCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.heightAnchor.constraint(equalToConstant: 95).isActive = true
        return card
    }()
    
    private let addClientButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Adicionar cliente", for: .normal)
        button.titleLabel?.font = Fonts.paragraphMedium()
        button.setTitleColor(Colors.textInvert, for: .normal)
        button.backgroundColor = Colors.accentBrand
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        // TODO: action
        return button
    }()
    
    private let viewAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ver todos", for: .normal)
        button.titleLabel?.font = Fonts.titleSmall()
        button.setTitleColor(Colors.accentBrand, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true
        // TODO: action
        return button
    }()
    
    private let companyListView: CompanyListView = {
        let companies = [
            CompanyItemModel(name: "Aurora Tech Soluções Digitais"),
            CompanyItemModel(name: "Veltrix Labs"),
            CompanyItemModel(name: "Rocket Seat"),
            CompanyItemModel(name: "ApertAi Replays")
        ]
        let view = CompanyListView(companies: companies)
        view.heightAnchor.constraint(equalToConstant: 144).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var companySectionStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            UIView(), viewAllButton
        ])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let transactionLabel: UILabel = {
        let label = UILabel()
        label.text = "Lançamentos"
        label.font = Fonts.titleSmall()
        label.textColor = Colors.textHeading
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Filtrar", for: .normal)
        button.titleLabel?.font = Fonts.paragraphMedium()
        button.setTitleColor(Colors.textHeading, for: .normal)
        button.setImage(UIImage(systemName: "line.horizontal.3.decrease.circle"), for: .normal)
        button.tintColor = Colors.textHeading
        button.backgroundColor = Colors.backgroundSecondary
        button.layer.cornerRadius = 6
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -4)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // TODO: action
        return button
    }()
    
    private lazy var transactionHeaderStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            transactionLabel, UIView(), filterButton
        ])
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let transactionDateLabel: UILabel = {
        let label = UILabel()
        label.text = "01 de abril"
        label.font = Fonts.paragraphSmall()
        label.textColor = Colors.textParagraph
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let transactionCardView: PaymentCardView = {
        let card = PaymentCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.heightAnchor.constraint(equalToConstant: 95).isActive = true
        return card
    }()
    
    private lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerStack,
            daySelectorView,
            todayStack,
            addClientButton,
            companySectionStack,
            companyListView,
            transactionHeaderStack,
            transactionDateLabel,
            transactionCardView
        ])
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupContent()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    private func setupView() {
        backgroundColor = Colors.backgroundPrimary

        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainStack)


        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            mainStack.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
        ])
        

    }

    // MARK: - Content

    private func setupContent() {
        paymentCardView.configure(
            with: .init(type: .incoming, name: "Aurora Tech Soluções Digitais", value: "R$ 250,00")
        )
        transactionCardView.configure(
            with: .init(type: .transaction, name: "Aluguel de Abril", value: "R$ 1.200,00")
        )
    }
}
