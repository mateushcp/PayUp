//
//  CompanyListView.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 11/05/25.
//

import Foundation
import UIKit

protocol CompanyListViewDelegate: AnyObject {
    func didSelectCompany(_ company: CompanyItemModel)
}

final class CompanyListView: UIView {
    private let viewModel: CompanyViewModel
    weak var delegate: CompanyListViewDelegate?
    
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
    
    init(companies: [CompanyItemModel]) {
        self.viewModel = CompanyViewModel(companies: companies)
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
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}

extension CompanyListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.companies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompanyCell.identifier,
                                                            for: indexPath) as? CompanyCell else {
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
