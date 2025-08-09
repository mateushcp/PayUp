import Foundation
import SQLite3

final class DatabaseManager {
    static let shared = DatabaseManager()
    private var db: OpaquePointer?
    
    private init() {
        openDatabase()
        createTable()
    }
    
    private func openDatabase() {
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("clients.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Unable to open database")
        }
    }
    
    private func createTable() {
        let createTableSQL = """
            CREATE TABLE IF NOT EXISTS clients(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            contact TEXT NOT NULL,
            phone TEXT NOT NULL,
            cnpj TEXT NOT NULL,
            address TEXT NOT NULL,
            value REAL NOT NULL,
            due_date TEXT NOT NULL,
            is_recurring INTEGER NOT NULL,
            frequency TEXT NOT NULL,
            selected_day INTEGER);
        """
        
        if sqlite3_exec(db, createTableSQL, nil, nil, nil) != SQLITE_OK {
            print("Unable to create table")
        }
    }
    
    func saveClient(name: String, contact: String, phone: String, cnpj: String, address: String, value: Double, dueDate: String, isRecurring: Bool, frequency: String, selectedDay: Int?) -> Bool {
        let insertSQL = "INSERT INTO clients (name, contact, phone, cnpj, address, value, due_date, is_recurring, frequency, selected_day) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertSQL, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, name, -1, nil)
            sqlite3_bind_text(statement, 2, contact, -1, nil)
            sqlite3_bind_text(statement, 3, phone, -1, nil)
            sqlite3_bind_text(statement, 4, cnpj, -1, nil)
            sqlite3_bind_text(statement, 5, address, -1, nil)
            sqlite3_bind_double(statement, 6, value)
            sqlite3_bind_text(statement, 7, dueDate, -1, nil)
            sqlite3_bind_int(statement, 8, isRecurring ? 1 : 0)
            sqlite3_bind_text(statement, 9, frequency, -1, nil)
            
            if let day = selectedDay {
                sqlite3_bind_int(statement, 10, Int32(day))
            } else {
                sqlite3_bind_null(statement, 10)
            }
            
            if sqlite3_step(statement) == SQLITE_DONE {
                sqlite3_finalize(statement)
                return true
            }
        }
        
        sqlite3_finalize(statement)
        return false
    }
    
    func getClients() -> [(id: Int, name: String, contact: String, phone: String, cnpj: String, address: String, value: Double, dueDate: String, isRecurring: Bool, frequency: String, selectedDay: Int?)] {
        let querySQL = "SELECT * FROM clients"
        var statement: OpaquePointer?
        var clients: [(id: Int, name: String, contact: String, phone: String, cnpj: String, address: String, value: Double, dueDate: String, isRecurring: Bool, frequency: String, selectedDay: Int?)] = []
        
        if sqlite3_prepare_v2(db, querySQL, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(statement, 0))
                let name = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                let contact = String(describing: String(cString: sqlite3_column_text(statement, 2)))
                let phone = String(describing: String(cString: sqlite3_column_text(statement, 3)))
                let cnpj = String(describing: String(cString: sqlite3_column_text(statement, 4)))
                let address = String(describing: String(cString: sqlite3_column_text(statement, 5)))
                let value = sqlite3_column_double(statement, 6)
                let dueDate = String(describing: String(cString: sqlite3_column_text(statement, 7)))
                let isRecurring = sqlite3_column_int(statement, 8) == 1
                let frequency = String(describing: String(cString: sqlite3_column_text(statement, 9)))
                let selectedDay = sqlite3_column_type(statement, 10) != SQLITE_NULL ? Int(sqlite3_column_int(statement, 10)) : nil
                
                clients.append((id: id, name: name, contact: contact, phone: phone, cnpj: cnpj, address: address, value: value, dueDate: dueDate, isRecurring: isRecurring, frequency: frequency, selectedDay: selectedDay))
            }
        }
        
        sqlite3_finalize(statement)
        return clients
    }
}