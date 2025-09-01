//
//  ClientFoormViewModel.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 09/08/25.
//

import Foundation

final class ClientFormViewModel {
    private let databaseManager = DatabaseManager.shared
    
    func saveClient(client: Client) {
        
        let cleanValue = client.value.replacingOccurrences(of: "R$", with: "").replacingOccurrences(of: ",", with: "")
        let DoubleValue = Double(cleanValue) ?? 0.0
        
        return databaseManager.saveClient(client)
        
    }
    
    func getAllClients() -> [Client] {
        return databaseManager.getClient()
    }
    
    func getClientById(id: Int) -> Client? {
        return databaseManager.getClient(by: id)
    }
}
