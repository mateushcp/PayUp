//
//  HomeView.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 01/05/25.
//

import UIKit

final class HomeView: UIView {
    
    // MARK: – Scroll + container
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = Colors.backgroundPrimary
        scrollView.bounces = true
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.layoutMargins = UIEdgeInsets(top: 16, left: 24, bottom: 24, right: 24)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.backgroundPrimary
        return view
    }()
    
    // MARK: – Header (logo + sininho + perfil)
    
    private lazy var headerStack: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [
            logoImage,
            spacer,
            bellButton,
            profileImage
        ])
        stackView.setCustomSpacing(24, after: bellButton)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mainLogo"))
        imageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 82),
            imageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        return imageView
    }()
    
    private let bellButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "bell"), for: .normal)
        button.tintColor = Colors.textHeading
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 24),
            button.heightAnchor.constraint(equalToConstant: 24)
        ])
        return button
    }()
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profileImage"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 44),
            imageView.heightAnchor.constraint(equalToConstant: 44)
        ])
        return imageView
    }()
    
    // MARK: – Day selector
    
    private let daySelectorView: DaySelectorView = {
        let view = DaySelectorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 32)
        ])
        return view
    }()
    
    // MARK: – Seção “Hoje”
    
    private let todayLabel: UILabel = {
        let label = UILabel()
        label.text = "Hoje"
        label.font = Fonts.titleSmall()
        label.textColor = Colors.textHeading
        return label
    }()
    
    private let paymentCardView: PaymentCardView = {
        let card = PaymentCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.heightAnchor.constraint(equalToConstant: 95).isActive = true
        return card
    }()
    
    private lazy var todayStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [todayLabel, paymentCardView])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    // MARK: – Botão adicionar cliente
    
    private let addClientButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Adicionar cliente", for: .normal)
        button.titleLabel?.font = Fonts.paragraphMedium()
        button.setTitleColor(Colors.textInvert, for: .normal)
        button.backgroundColor = Colors.accentBrand
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return button
    }()
    
    // MARK: – Seção “Empresas”
    
    private let viewAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ver todos", for: .normal)
        button.titleLabel?.font = Fonts.titleSmall()
        button.setTitleColor(Colors.accentBrand, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 21).isActive = true
        return button
    }()
    
    private let companyListView: CompanyListView = {
        let models = [
            CompanyItemModel(name: "Aurora Tech Soluções Digitais"),
            CompanyItemModel(name: "Veltrix Labs"),
            CompanyItemModel(name: "Rocket Seat"),
            CompanyItemModel(name: "ApertAi Replays")
        ]
        let view = CompanyListView(companies: models)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 141).isActive = true
        return view
    }()
    
    private lazy var companySectionStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [UIView(), viewAllButton])
        stackView.axis = .horizontal
        return stackView
    }()
    
    // MARK: – Seção “Lançamentos”
    
    private let transactionLabel: UILabel = {
        let label = UILabel()
        label.text = "Lançamentos"
        label.font = Fonts.titleSmall()
        label.textColor = Colors.textHeading
        return label
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Filtrar", for: .normal)
        button.titleLabel?.font = Fonts.paragraphMedium()
        button.setTitleColor(Colors.textHeading, for: .normal)
        button.setImage(
          UIImage(systemName: "line.horizontal.3.decrease.circle"),
          for: .normal
        )
        button.tintColor = Colors.textHeading
        button.backgroundColor = Colors.backgroundSecondary
        button.layer.cornerRadius = 6
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -4)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()
    
    private lazy var transactionHeaderStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [transactionLabel, UIView(), filterButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    private let transactionDateLabel: UILabel = {
        let label = UILabel()
        label.text = "01 de abril"
        label.font = Fonts.paragraphSmall()
        label.textColor = Colors.textParagraph
        return label
    }()
    
    private let transactionCardView: PaymentCardView = {
        let card = PaymentCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.heightAnchor.constraint(equalToConstant: 95).isActive = true
        return card
    }()
        
    // MARK: – Main Stack

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

    // MARK: – Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupContent()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: – Layout

    private func setupLayout() {
        backgroundColor = Colors.backgroundPrimary

        addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])

        // 2) mainStack no contentView usando suas layoutMargins
        contentView.addSubview(mainStack)
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }

    // MARK: – Content

    private func setupContent() {
        paymentCardView.configure(
          with: .init(type: .incoming, name: "Aurora Tech Soluções Digitais", value: "R$ 250,00")
        )
        transactionCardView.configure(
          with: .init(type: .transaction, name: "Aluguel de Abril", value: "R$ 1.200,00")
        )
    }
}
