//
//  HomeView.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 01/05/25.
//

import Foundation
import UIKit

final class HomeView: UIView {
    
    let logoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mainLogo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let mockCompanies = [
        CompanyItemModel(name: "Aurora Tech Soluções Digitais"),
        CompanyItemModel(name: "Veltrix Labs"),
        CompanyItemModel(name: "Rocket Seat"),
        CompanyItemModel(name: "ApertAi Replays"),
    ]
    
    let bellButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "bell"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = Colors.textHeading
        return button
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profileImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    let daySelectorView = DaySelectorView()
    let paymentCardView = PaymentCardView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
        setupPaymentCard()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = Colors.backgroundPrimary
        addSubview(logoImage)
        addSubview(profileImage)
        addSubview(bellButton)
        addSubview(daySelectorView)
        addSubview(paymentCardView)
        let companyListView = CompanyListView(companies: mockCompanies)
        addSubview(companyListView)
        
        daySelectorView.translatesAutoresizingMaskIntoConstraints = false
        paymentCardView.translatesAutoresizingMaskIntoConstraints = false
        companyListView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -24),
            logoImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            logoImage.heightAnchor.constraint(equalToConstant: 24),
            logoImage.widthAnchor.constraint(equalToConstant: 82),
            
            profileImage.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            profileImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            profileImage.heightAnchor.constraint(equalToConstant: 44),
            profileImage.widthAnchor.constraint(equalToConstant: 44),
            
            bellButton.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            bellButton.trailingAnchor.constraint(equalTo: profileImage.leadingAnchor, constant: -24),
            bellButton.heightAnchor.constraint(equalToConstant: 24),
            bellButton.widthAnchor.constraint(equalToConstant: 24),
            
            daySelectorView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 55),
            daySelectorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            daySelectorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            daySelectorView.heightAnchor.constraint(equalToConstant: 32),
            
            paymentCardView.topAnchor.constraint(equalTo: daySelectorView.bottomAnchor, constant: 24),
            paymentCardView.leadingAnchor.constraint(equalTo: daySelectorView.leadingAnchor),
            paymentCardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            paymentCardView.heightAnchor.constraint(equalToConstant: 95),
            
            companyListView.topAnchor.constraint(equalTo: paymentCardView.bottomAnchor, constant: 24),
            companyListView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            companyListView.trailingAnchor.constraint(equalTo: trailingAnchor),
            companyListView.heightAnchor.constraint(equalToConstant: 141)

        ])
    }
    
    private func setupCollectionView() {
        //vai ser aqui no futuro
    }
    
    private func setupPaymentCard() {
        let transactionModel = PaymentCardModel(type: .incoming,
                                                name: "Aurora Tech soluções Digitais",
                                                value: "R$ 250,00")
        paymentCardView.configure(with: transactionModel)
    }
}
