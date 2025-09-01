import Foundation

final class ClientFormViewModel {
    private let databaseManager = DatabaseManager.shared
    
    func saveClient(_ client: Client) -> Bool {
        return databaseManager.saveClient(client)
    }
    
    func getAllClients() -> [Client] {
        return databaseManager.getClients()
    }
    
    func getClient(by id: Int) -> Client? {
        return databaseManager.getClient(by: id)
    }
}