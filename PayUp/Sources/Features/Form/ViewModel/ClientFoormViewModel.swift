//
//  ClientFoormViewModel.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 09/08/25.
//

import Foundation

final class ClientFormViewModel {
    private let databaseManager = DatabaseManager.shared
    private let notificationManager = NotificationManager.shared
    
    func saveClient(client: Client) -> Bool {
        let success = databaseManager.saveClient(client)
        
        if success {
            if client.isRecurring {
                notificationManager.scheduleClientReminders(for: client)
            } else {
                print("Cliente nao colocou um lembere")
            }
        }
        return success
    }
    
    func getAllClients() -> [Client] {
        return databaseManager.getClient()
    }
    
    func getClientById(id: Int) -> Client? {
        return databaseManager.getClient(by: id)
    }
    
    func deleteClient(by id: Int) -> Bool {
        notificationManager.cancelClientReminders(clientId: id)
        return databaseManager.deleteClient(by: id)
    }
}
