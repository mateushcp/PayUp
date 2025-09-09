//
//  HomeViewModl.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 01/09/25.
//

import Foundation

final class HomeViewModel {
    private let databaseManager = DatabaseManager.shared
    
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
}
