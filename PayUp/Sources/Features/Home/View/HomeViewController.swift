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
        setupCompanyListDelegate()
        setupDaySelectorDelegate()
        setupNotificationObserver()
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
        let todayTransactions = viewModel.getTodayTransactions()
        let todayDateString = viewModel.getTodayDateString()
        
        homeView.updateCompanyList(companies: clients)
        homeView.updateTodayValue(value: formatedVallue)
        homeView.updateTransactions(todayTransactions)
        homeView.updateTransactionDate(todayDateString)
    }
    
    private func setupCompanyListDelegate() {
        homeView.setCompanyListDelegate(self)
    }
    
    private func setupDaySelectorDelegate() {
        homeView.setDaySelectorDelegate(self)
    }
    
    private func setupNotificationObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleClientDataChanged),
            name: .clientDataChanged,
            object: nil
        )
    }
    
    @objc private func handleClientDataChanged() {
        loadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension HomeViewController: CompanyListViewDelegate {
    func didSelectCompany(_ company: CompanyItemModel) {
        guard let client = viewModel.getClientByName(company.name) else {
            print("Cliente não encontrado para edição")
            return
        }
        
        let formViewController = ClientFormViewController(mode: .edit(client))
        formViewController.modalTransitionStyle = .coverVertical
        formViewController.modalPresentationStyle = .overFullScreen
        self.present(formViewController, animated: true)
    }
}

extension HomeViewController: DaySelectorViewDelegate {
    func didSelectDay(_ date: Date) {
        let transactions = viewModel.getTransactionsForDate(date)
        let dateString = viewModel.getDateString(for: date)
        
        homeView.updateTransactions(transactions)
        homeView.updateTransactionDate(dateString)
    }
}
