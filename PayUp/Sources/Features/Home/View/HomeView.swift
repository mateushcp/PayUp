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
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    private let contentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    // MARK: - Subviews

    private let logoImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "mainLogo"))
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let bellButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "bell"), for: .normal)
        btn.tintColor = Colors.textHeading
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    private let profileImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "profileImage"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 16
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let daySelectorView: DaySelectorView = {
        let v = DaySelectorView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let hojeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Hoje"
        lbl.font = Fonts.titleSmall()
        lbl.textColor = Colors.textHeading
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private let paymentCardView: PaymentCardView = {
        let card = PaymentCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()

    private let addClientButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Adicionar cliente", for: .normal)
        btn.titleLabel?.font = Fonts.paragraphMedium()
        btn.setTitleColor(Colors.textInvert, for: .normal)     // agora usa texto escuro
        btn.backgroundColor = Colors.accentBrand
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        // TODO: action
        return btn
    }()

    /// “Ver todos” reposicionado para ficar acima da companyList com espaçamento
    private let viewAllButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Ver todos", for: .normal)
        btn.titleLabel?.font = Fonts.titleSmall()          // K2D-700 / 16pt
        btn.setTitleColor(Colors.accentBrand, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        // TODO: action
        return btn
    }()

    private let companyListView: CompanyListView = {
        let companies = [
            CompanyItemModel(name: "Aurora Tech Soluções Digitais"),
            CompanyItemModel(name: "Veltrix Labs"),
            CompanyItemModel(name: "Rocket Seat"),
            CompanyItemModel(name: "ApertAi Replays")
        ]
        let v = CompanyListView(companies: companies)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let lancamentosLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Lançamentos"
        lbl.font = Fonts.titleSmall()
        lbl.textColor = Colors.textHeading
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private let filterButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Filtrar", for: .normal)
        btn.titleLabel?.font = Fonts.paragraphMedium()           // K2D-600 / 16pt
        btn.setTitleColor(Colors.textHeading, for: .normal)     // branco
        btn.setImage(UIImage(systemName: "line.horizontal.3.decrease.circle"), for: .normal)
        btn.tintColor = Colors.textHeading
        btn.backgroundColor = Colors.backgroundSecondary
        btn.layer.cornerRadius = 6
        btn.semanticContentAttribute = .forceRightToLeft
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -4)
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        btn.translatesAutoresizingMaskIntoConstraints = false
        // TODO: action
        return btn
    }()

    private let lancamentosDateLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "01 de abril"
        lbl.font = Fonts.paragraphSmall()
        lbl.textColor = Colors.textParagraph
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private let lancamentoCardView: PaymentCardView = {
        let card = PaymentCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
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

        // 1) Scroll + contentView
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            // scrollView ocupa toda a view, respeitando safeArea
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            // contentView dentro do scroll
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),

            // width do contentView fixa igual à width da scrollView
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])

        // 2) adiciona subviews dentro do contentView
        let views: [UIView] = [
            logoImage, bellButton, profileImage,
            daySelectorView, hojeLabel, paymentCardView,
            addClientButton, viewAllButton, companyListView,
            lancamentosLabel, filterButton,
            lancamentosDateLabel, lancamentoCardView
        ]
        views.forEach { contentView.addSubview($0) }

        // 3) constraints dos elementos
        NSLayoutConstraint.activate([
            // Topo
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            logoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            logoImage.widthAnchor.constraint(equalToConstant: 82),
            logoImage.heightAnchor.constraint(equalToConstant: 24),

            profileImage.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            profileImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            profileImage.widthAnchor.constraint(equalToConstant: 44),
            profileImage.heightAnchor.constraint(equalToConstant: 44),

            bellButton.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            bellButton.trailingAnchor.constraint(equalTo: profileImage.leadingAnchor, constant: -24),
            bellButton.widthAnchor.constraint(equalToConstant: 24),
            bellButton.heightAnchor.constraint(equalToConstant: 24),

            // Day selector
            daySelectorView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 24),
            daySelectorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            daySelectorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            daySelectorView.heightAnchor.constraint(equalToConstant: 32),

            // “Hoje”
            hojeLabel.topAnchor.constraint(equalTo: daySelectorView.bottomAnchor, constant: 24),
            hojeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),

            // Card “Hoje”
            paymentCardView.topAnchor.constraint(equalTo: hojeLabel.bottomAnchor, constant: 8),
            paymentCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            paymentCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            paymentCardView.heightAnchor.constraint(equalToConstant: 95),

            // Botão Adicionar cliente
            addClientButton.topAnchor.constraint(equalTo: paymentCardView.bottomAnchor, constant: 16),
            addClientButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            addClientButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            addClientButton.heightAnchor.constraint(equalToConstant: 48),

            // “Ver todos” acima da lista
            viewAllButton.topAnchor.constraint(equalTo: addClientButton.bottomAnchor, constant: 24),
            viewAllButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            viewAllButton.heightAnchor.constraint(equalToConstant: 21),

            // Lista de empresas
            companyListView.topAnchor.constraint(equalTo: viewAllButton.bottomAnchor, constant: 16),
            companyListView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            companyListView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            companyListView.heightAnchor.constraint(equalToConstant: 141),

            lancamentosLabel.topAnchor.constraint(equalTo: companyListView.bottomAnchor, constant: 24),
            lancamentosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),

            filterButton.centerYAnchor.constraint(equalTo: lancamentosLabel.centerYAnchor),
            filterButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            filterButton.heightAnchor.constraint(equalToConstant: 40),

            lancamentosDateLabel.topAnchor.constraint(equalTo: lancamentosLabel.bottomAnchor, constant: 16),
            lancamentosDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),

            lancamentoCardView.topAnchor.constraint(equalTo: lancamentosDateLabel.bottomAnchor, constant: 8),
            lancamentoCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            lancamentoCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            lancamentoCardView.heightAnchor.constraint(equalToConstant: 95),

            lancamentoCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }

    // MARK: - Content

    private func setupContent() {
        paymentCardView.configure(
            with: .init(type: .incoming, name: "Aurora Tech Soluções Digitais", value: "R$ 250,00")
        )
        lancamentoCardView.configure(
            with: .init(type: .transaction, name: "Aluguel de Abril", value: "R$ 1.200,00")
        )
    }
}
