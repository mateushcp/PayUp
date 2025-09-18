//
//  HomeViewModl.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 01/09/25.
//

import Foundation

final class HomeViewModel {
    private let databaseManager = DatabaseManager.shared
    private var currentNameFilter: String?
    private var currentDayFilter: String?
    
    func getAllClients() -> [Client] {
        return databaseManager.getClient()
    }
    
    func getTodayClinets() -> [Client] {
        let allClientes = getAllClients()
        let today = Date()
        let dateforamtter = DateFormatter()
        dateforamtter.dateFormat = "dd/MM/yyyy"
        let todayString = dateforamtter.string(from: today)
        
        
        return allClientes.filter { client in
            return client.dueDate == todayString
        }
    }
    
    func getCompanyModelsFromClients() -> [CompanyItemModel] {
        let clients = getAllClients()
        
        return clients.map { client in
            CompanyItemModel(name: client.name)
        }
    }
    
    func getTotalValueForToday() -> Double {
        let todayClients = getTodayClinets()
        return todayClients.reduce(0) { total, client in
            return total + client.value
        }
    }
    
    func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(value: value)) ?? "RS 0,00"
    }
    
    func getClientByName(_ name: String) -> Client? {
        let allClients = getAllClients()
        return allClients.first { $0.name == name }
    }
    
    func getTodayTransactions() -> [PaymentCardModel] {
        let todayClients = getTodayClinets()
        let filteredClients = applyFilters(to: todayClients)
        
        return filteredClients.map { client in
            PaymentCardModel(
                type: .transaction,
                name: client.name,
                value: formatCurrency(client.value)
            )
        }
    }
    
    func getTransactionsForDate(_ date: Date) -> [PaymentCardModel] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: date)
        
        let allClients = getAllClients()
        let clientsForDate = allClients.filter { client in
            return client.dueDate == dateString
        }
        
        let filteredClients = applyFilters(to: clientsForDate)
        
        return filteredClients.map { client in
            PaymentCardModel(
                type: .transaction,
                name: client.name,
                value: formatCurrency(client.value)
            )
        }
    }
    
    private func applyFilters(to clients: [Client]) -> [Client] {
        var filteredClients = clients
        
        // Filtro por nome
        if let nameFilter = currentNameFilter, !nameFilter.isEmpty {
            filteredClients = filteredClients.filter { client in
                client.name.lowercased().contains(nameFilter.lowercased())
            }
        }
        
        // Filtro por dia
        if let dayFilter = currentDayFilter, !dayFilter.isEmpty {
            filteredClients = filteredClients.filter { client in
                client.dueDate.contains(dayFilter)
            }
        }
        
        return filteredClients
    }
    
    func setNameFilter(_ nameFilter: String?) {
        currentNameFilter = nameFilter
    }
    
    func setDayFilter(_ dayFilter: String?) {
        currentDayFilter = dayFilter
    }
    
    func clearFilters() {
        currentNameFilter = nil
        currentDayFilter = nil
    }
    
    func getTodayDateString() -> String {
        return getDateString(for: Date())
    }
    
    func getDateString(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd 'de' MMMM"
        dateFormatter.locale = .current
        return dateFormatter.string(from: date)
    }
}
