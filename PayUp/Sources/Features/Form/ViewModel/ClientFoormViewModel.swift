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
        if let savedClientId = databaseManager.saveClientAndReturnId(client) {
            if client.isRecurring {
                let clientWithId = Client(
                    id: savedClientId,
                    name: client.name,
                    contact: client.contact,
                    phone: client.phone,
                    cnpj: client.cnpj,
                    address: client.address,
                    value: client.value,
                    dueDate: client.dueDate,
                    isRecurring: client.isRecurring,
                    frequency: client.frequency,
                    selectedDay: client.selectedDay
                )
                notificationManager.scheduleClientReminders(for: clientWithId)
            } else {
                print("Cliente nao colocou um lembere")
            }
            return true
        }
        return false
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
