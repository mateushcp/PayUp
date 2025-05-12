//
//  SplashViewController.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 21/04/25.
//

import Foundation
import UIKit

final class SplashViewController: UIViewController {
    private let viewModel: SplashViewModel
    private let splashView = SplashView()
    
    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.view = splashView
        startAnimation()
    }
    
    private func startAnimation() {
        splashView.triangleImageView.transform = CGAffineTransform(scaleX: 2.5,
                                                                   y: 2.5)
        
        viewModel.performInitialAnimation { [ weak self ] in
            guard let self = self else {
                return
            }
            
            UIView.animate(withDuration: 0.8, animations: {
                self.splashView.triangleImageView.alpha = 1
                self.splashView.triangleImageView.transform = .identity
            }, completion:  { _ in
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut) {
                    self.splashView.logoImageView.alpha = 1
                } completion: { _ in
                    self.viewModel.onAnimationCompleted?()
                }
            })
        }
    }
}
