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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = Colors.backgroundPrimary
        addSubview(logoImage)
        addSubview(profileImage)
        addSubview(bellButton)
        
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
            bellButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
}
