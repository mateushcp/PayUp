//
//  CompanyCell.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 11/05/25.
//

import Foundation
import UIKit

final class CompanyCell: UICollectionViewCell {
    static let identifier = "CompanyCell"
    
    private let iconBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.backgroundTertiary
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "company"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.textHeading
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Fonts.titleSmall()
        label.textColor = Colors.textHeading
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = Colors.backgroundSecondary
        layer.cornerRadius = 6
        addSubview(iconBackgroundView)
        iconBackgroundView.addSubview(iconImageView)
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            iconBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            iconBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            iconBackgroundView.widthAnchor.constraint(equalToConstant: 31),
            iconBackgroundView.heightAnchor.constraint(equalToConstant: 31),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconBackgroundView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconBackgroundView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            nameLabel.topAnchor.constraint(equalTo: iconBackgroundView.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
    
    func configure(with model: CompanyItemModel) {
        nameLabel.text = model.name
    }
}
