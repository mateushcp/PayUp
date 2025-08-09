import Foundation

final class ClientFormViewModel {
    private let databaseManager = DatabaseManager.shared
    
    func saveClient(
        name: String,
        contact: String, 
        phone: String,
        cnpj: String,
        address: String,
        value: String,
        dueDate: String,
        isRecurring: Bool,
        frequency: String,
        selectedDay: Int?
    ) -> Bool {
        let cleanValue = value.replacingOccurrences(of: "R$ ", with: "").replacingOccurrences(of: ",", with: ".")
        let doubleValue = Double(cleanValue) ?? 0.0
        
        return databaseManager.saveClient(
            name: name,
            contact: contact,
            phone: phone,
            cnpj: cnpj,
            address: address,
            value: doubleValue,
            dueDate: dueDate,
            isRecurring: isRecurring,
            frequency: frequency,
            selectedDay: selectedDay
        )
    }
    
    func getAllClients() -> [(id: Int, name: String, contact: String, phone: String, cnpj: String, address: String, value: Double, dueDate: String, isRecurring: Bool, frequency: String, selectedDay: Int?)] {
        return databaseManager.getClients()
    }
}