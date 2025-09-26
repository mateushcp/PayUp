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
    private var currentlySelectedDate: Date = Date()
    
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
        
        homeView.onTapFilter = { [weak self] in
            self?.showFilterOptions()
        }
    }
    
    private func showFilterOptions() {
        let alert = UIAlertController(title: "Filtrar", message: "Escolha como filtrar os lançamentos", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Filtrar por Nome", style: .default) { _ in
            self.showNameFilterAlert()
        })
        
        alert.addAction(UIAlertAction(title: "Filtrar por Dia", style: .default) { _ in
            self.showDayFilterAlert()
        })
        
        alert.addAction(UIAlertAction(title: "Limpar Filtros", style: .destructive) { _ in
            self.viewModel.clearFilters()
            self.refreshCurrentData()
        })
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func showNameFilterAlert() {
        let alert = UIAlertController(title: "Filtrar por Nome", message: "Digite o nome do cliente", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Nome do cliente"
        }
        
        alert.addAction(UIAlertAction(title: "Filtrar", style: .default) { _ in
            let name = alert.textFields?.first?.text
            self.viewModel.setNameFilter(name)
            self.refreshCurrentData()
        })
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func showDayFilterAlert() {
        let alert = UIAlertController(title: "Filtrar por Dia", message: "Digite o dia (ex: 15, 01, 30)", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Dia (01-31)"
            textField.keyboardType = .numberPad
        }
        
        alert.addAction(UIAlertAction(title: "Filtrar", style: .default) { _ in
            let day = alert.textFields?.first?.text
            self.viewModel.setDayFilter(day)
            self.refreshCurrentData()
        })
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func refreshCurrentData() {
        let transactions = viewModel.getTransactionsForDate(currentlySelectedDate)
        let dateString = viewModel.getDateString(for: currentlySelectedDate)

        homeView.updateTransactions(transactions)
        homeView.updateTransactionDate(dateString)
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
        currentlySelectedDate = date
        let transactions = viewModel.getTransactionsForDate(date)
        let dateString = viewModel.getDateString(for: date)

        homeView.updateTransactions(transactions)
        homeView.updateTransactionDate(dateString)
    }
}
