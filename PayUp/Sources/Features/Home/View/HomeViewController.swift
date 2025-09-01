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
    private let viewModel = HomeViewModel()
    
    override func loadView() {
        self.view = homeView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setupCallForAddClient()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    private func setupCallForAddClient() {
        homeView.onTapAddClient = { [ weak self ] in
            guard let self = self else { return }
            let formViewController = ClientFormViewController(mode: .add)
            formViewController.modalTransitionStyle = .coverVertical
            formViewController.modalPresentationStyle = .overFullScreen
            self.present(formViewController, animated: true)
        }
    }
    
    private func loadData() {
        let clients = viewModel.getCompanyModelsFromClients()
        let todayValue = viewModel.getTotalValueForToday()
        let formatedVallue = viewModel.formatCurrency(todayValue)
        
        homeView.updateCompanyList(companies: clients)
        homeView.updateTodayValue(value: formatedVallue)
    }
}
