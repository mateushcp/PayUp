//
//  HomeViewController.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 01/05/25.
//

import Foundation
import UIKit

final class HomeViewController: UIViewController {
    private let homeView = HomeView()
    
    override func loadView() {
        self.view = homeView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        homeView.onTapAddClient = { [weak self] in
            guard let self = self else { return }
            // 2) crie e apresente o form
            let formVC = ClientFormViewController(mode: .add)
            formVC.modalPresentationStyle = .overFullScreen
            formVC.modalTransitionStyle = .coverVertical
            self.present(formVC, animated: true)
        }
    }
}
