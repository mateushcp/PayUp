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
        
        
        daySelectorView.translatesAutoresizingMaskIntoConstraints = false
        paymentCardView.translatesAutoresizingMaskIntoConstraints = false
        
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
            paymentCardView.heightAnchor.constraint(equalToConstant: 95)

        ])
    }
    
    private func setupPaymentCard() {
        paymentCardView.configure(name: "autora Tech Soluções Digitais", value: "R$ 250,00")
    }
}
