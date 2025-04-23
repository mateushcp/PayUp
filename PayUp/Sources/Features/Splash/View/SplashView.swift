//
//  SplashView.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 21/04/25.
//

import Foundation
import UIKit

final class SplashView: UIView {
    
    let triangleImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "animatedSplashTriangle"))
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0
        return imageView
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mainLogo"))
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0
        return imageView
    }()
    
    let faceIDView = FaceIDView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = Colors.backgroundPrimary
        addSubview(triangleImageView)
        addSubview(logoImageView)
        addSubview(faceIDView)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        triangleImageView.frame = bounds
        logoImageView.center = center
        logoImageView.bounds.size = CGSize(width: 100,
                                           height: 100)
        faceIDView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            faceIDView.centerXAnchor.constraint(equalTo: centerXAnchor),
            faceIDView.centerYAnchor.constraint(equalTo: centerYAnchor),
            faceIDView.widthAnchor.constraint(equalToConstant: 343),
            faceIDView.heightAnchor.constraint(equalToConstant: 606)
        ])

    }
    
    func showFaceIDView() {
        UIView.animate(withDuration: 0.5) {
            self.faceIDView.alpha = 1
        }
    }
}


