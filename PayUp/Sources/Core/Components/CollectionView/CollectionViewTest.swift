//
//  CollectionViewTest.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 11/05/25.
//

import Foundation

struct CompanyItemViewModel {
    let name: String
}

// CompanyListViewModel.swift
final class CompanyListViewModel {
    var companies: [CompanyItemViewModel] = []

    init(companies: [CompanyItemViewModel]) {
        self.companies = companies
    }
}

// CompanyCell.swift
import UIKit

final class CompanyCell: UICollectionViewCell {
    static let identifier = "CompanyCell"

    private let iconBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.backgroundTertiary // ou Colors.backgroundTertiary se preferir
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

    func configure(with viewModel: CompanyItemViewModel) {
        nameLabel.text = viewModel.name
    }

    private func setupView() {
        contentView.backgroundColor = Colors.backgroundSecondary
        contentView.layer.cornerRadius = 6
        contentView.addSubview(iconBackgroundView)
        iconBackgroundView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            iconBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            iconBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            iconBackgroundView.widthAnchor.constraint(equalToConstant: 31),
            iconBackgroundView.heightAnchor.constraint(equalToConstant: 31),

            iconImageView.centerXAnchor.constraint(equalTo: iconBackgroundView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconBackgroundView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),

            nameLabel.topAnchor.constraint(equalTo: iconBackgroundView.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }
}

// CompanyListView.swift
import UIKit

final class CompanyListView: UIView {

    private let viewModel: CompanyListViewModel

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(CompanyCell.self, forCellWithReuseIdentifier: CompanyCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    init(companies: [CompanyItemViewModel]) {
        self.viewModel = CompanyListViewModel(companies: companies)
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

extension CompanyListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.companies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompanyCell.identifier, for: indexPath) as? CompanyCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel.companies[indexPath.item])
        return cell
    }
}

extension CompanyListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: 141)
    }
}
