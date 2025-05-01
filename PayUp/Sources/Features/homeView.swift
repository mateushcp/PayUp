//
//  homeView.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 01/05/25.
//

import UIKit

final class HomeView: UIView {

    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mainLogo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let bellButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bell"), for: .normal)
        button.tintColor = Colors.textHeading
        return button
    }()

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.image = UIImage(named: "profileImage") // sua imagem de avatar
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
        addSubview(logoImageView)
        addSubview(bellButton)
        addSubview(profileImageView)

        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        bellButton.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -24),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            logoImageView.heightAnchor.constraint(equalToConstant: 24),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),

            profileImageView.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            profileImageView.heightAnchor.constraint(equalToConstant: 44),
            profileImageView.widthAnchor.constraint(equalToConstant: 44),

            bellButton.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            bellButton.trailingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: -24),
            bellButton.heightAnchor.constraint(equalToConstant: 24),
            bellButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
}

// HomeViewController.swift
import UIKit

final class HomeViewController: UIViewController {

    private let homeView = HomeView()

    override func loadView() {
        self.view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
