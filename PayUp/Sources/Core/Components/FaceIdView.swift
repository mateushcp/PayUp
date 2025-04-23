//
//  FaceIdView.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 23/04/25.
//

import Foundation
import UIKit
import LocalAuthentication

final class FaceIDView: UIView {

    private let backgroundView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "backgroundView"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mainLogo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.titleLarge()
        label.textColor = Colors.textHeading
        label.text = "Olá Calisto,"
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.paragraphMedium()
        label.textColor = Colors.textParagraph
        label.text = "Desbloqueie com segurança usando o Face ID."
        label.numberOfLines = 2
        return label
    }()

    private let faceIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "faceId"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let ellipse1 = UIImageView(image: UIImage(named: "Ellipse1"))
    private let ellipse2 = UIImageView(image: UIImage(named: "Ellipse2"))
    private let ellipse3 = UIImageView(image: UIImage(named: "Ellipse3"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        animateEllipses()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(backgroundView)
        addSubview(logoImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(ellipse1)
        addSubview(ellipse2)
        addSubview(ellipse3)
        addSubview(faceIcon)

        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        faceIcon.translatesAutoresizingMaskIntoConstraints = false
        ellipse1.translatesAutoresizingMaskIntoConstraints = false
        ellipse2.translatesAutoresizingMaskIntoConstraints = false
        ellipse3.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),

            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 48),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),

            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 64),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),

            faceIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            faceIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            faceIcon.widthAnchor.constraint(equalToConstant: 40),
            faceIcon.heightAnchor.constraint(equalToConstant: 40),

            ellipse1.centerXAnchor.constraint(equalTo: faceIcon.centerXAnchor),
            ellipse1.centerYAnchor.constraint(equalTo: faceIcon.centerYAnchor),
            ellipse2.centerXAnchor.constraint(equalTo: faceIcon.centerXAnchor),
            ellipse2.centerYAnchor.constraint(equalTo: faceIcon.centerYAnchor),
            ellipse3.centerXAnchor.constraint(equalTo: faceIcon.centerXAnchor),
            ellipse3.centerYAnchor.constraint(equalTo: faceIcon.centerYAnchor)
        ])
    }

    private func animateEllipses() {
        let ellipses = [ellipse3, ellipse2, ellipse1]
        for (index, ellipse) in ellipses.enumerated() {
            ellipse.alpha = 0
            UIView.animate(withDuration: 1.5, delay: Double(index) * 0.4, options: [.repeat, .autoreverse]) {
                ellipse.alpha = 0.18
            }
        }
    }
}
