//
//  DatabaseManager.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 08/08/25.
//

import Foundation
import SQLite3

final class DatabaseManager {
    static let shared = DatabaseManager()
    private var db: OpaquePointer?
    
    private init() {
        openDataBase()
        createTable()
    }
    
    private func openDataBase() {
        let fileURl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        if sqlite3_open(fileURl.path, &db) != SQLITE_OK {
            print("Unable to open db")
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
            adress TEXT NOT NULL,
            value REAL NOT NULL,
            due_date TEXT NOT NULL,
            is_recurring INTEGER NOT NULL,
            frequency TEXT NOT NULL,
            selected_Day INTEGER NOT NULL,
"""
        
        if sqlite3_exec(db, createTableSQL, nil, nil, nil) != SQLITE_OK {
            print("Unable toc create the table")
        }
    }
    
    func saveClient(_ client: Client) -> Bool {
        let insertSQL = "INSERT INTO clients (name, contact, phone, cnpj, address, value, due_date, is_recurring, frequency, selected_day) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertSQL, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, client.name, -1, nil)
            sqlite3_bind_text(statement, 2, client.contact, -1, nil)
            sqlite3_bind_text(statement, 3, client.phone, -1, nil)
            sqlite3_bind_text(statement, 4, client.cnpj, -1, nil)
            sqlite3_bind_text(statement, 5, client.address, -1, nil)
            sqlite3_bind_double(statement, 6, client.value)
            sqlite3_bind_text(statement, 7, client.dueDate, -1, nil)
            sqlite3_bind_int(statement, 8, client.isRecurring ? 1 : 0)
            sqlite3_bind_text(statement, 9, client.frequency, -1, nil)
            
            if let day = client.selectedDay {
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
    
    func getClient() -> [Client] {
        let querySQL = "SELECT * FROM clients"
        var statement: OpaquePointer?
        var clients: [Client] = []
        
        if sqlite3_prepare(db, querySQL, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(statement, 0))
                let name = String(cString: sqlite3_column_text(statement, 1))
                let contact = String(cString: sqlite3_column_text(statement, 2))
                let phone = String(cString: sqlite3_column_text(statement, 3))
                let cnpj = String(cString: sqlite3_column_text(statement, 4))
                let address = String(cString: sqlite3_column_text(statement, 5))
                let value = sqlite3_column_double(statement, 6)
                let dueDate = String(cString: sqlite3_column_text(statement, 7))
                let isRecurring = sqlite3_column_int(statement, 8) == 1
                let frequency = String(cString: sqlite3_column_text(statement, 9))
                let selectedDay = sqlite3_column_type(statement, 10) != SQLITE_NULL ? Int(sqlite3_column_int(statement, 10)) : nil
                
                
                let client = Client(id: id,
                                    name: name,
                                    contact: contact,
                                    phone: phone,
                                    cnpj: cnpj,
                                    address: address,
                                    value: value,
                                    dueDate: dueDate,
                                    isRecurring: isRecurring,
                                    frequency: frequency)
                
                clients.append(client)
            }
        }
        
        sqlite3_finalize(statement)
        return clients
    }
    
    func getClient(by id: Int) -> Client? {
        let querySQL = "SELECT * FROM clients WHERE id = ?"
        var statement: OpaquePointer?
        
        if sqlite3_prepare(db, querySQL, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(statement, 0))
                let name = String(cString: sqlite3_column_text(statement, 1))
                let contact = String(cString: sqlite3_column_text(statement, 2))
                let phone = String(cString: sqlite3_column_text(statement, 3))
                let cnpj = String(cString: sqlite3_column_text(statement, 4))
                let address = String(cString: sqlite3_column_text(statement, 5))
                let value = sqlite3_column_double(statement, 6)
                let dueDate = String(cString: sqlite3_column_text(statement, 7))
                let isRecurring = sqlite3_column_int(statement, 8) == 1
                let frequency = String(cString: sqlite3_column_text(statement, 9))
                let selectedDay = sqlite3_column_type(statement, 10) != SQLITE_NULL ? Int(sqlite3_column_int(statement, 10)) : nil
                
                sqlite3_finalize(statement)
                
                return Client(id: id,
                              name: name,
                              contact: contact,
                              phone: phone,
                              cnpj: cnpj,
                              address: address,
                              value: value,
                              dueDate: dueDate,
                              isRecurring: isRecurring,
                              frequency: frequency)
                
            }
        }
        
        sqlite3_finalize(statement)
        return nil
    }
    
    func deleteClient(by id: Int) -> Bool {
        let deleteSQL = "DELETE FROM clients WHERE id = ?"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, deleteSQL, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(id))
            
            if sqlite3_step(statement) == SQLITE_DONE {
                sqlite3_finalize(statement)
                return true
            }
        }
        
        sqlite3_finalize(statement)
        return false
    }
}
