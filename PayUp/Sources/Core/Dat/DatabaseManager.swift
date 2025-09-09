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
        let fileURl = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("clients.sqlite")
        
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
            address TEXT NOT NULL,
            value REAL NOT NULL,
            due_date TEXT NOT NULL,
            is_recurring INTEGER NOT NULL,
            frequency TEXT NOT NULL,
            selected_day INTEGER
            );
        """
        
        if sqlite3_exec(db, createTableSQL, nil, nil, nil) != SQLITE_OK {
            print("Unable to create the table")
        }
    }
    
    func saveClient(_ client: Client) -> Bool {
        if let _ = client.id {
            return updateClient(client)
        } else {
            return insertClient(client)
        }
    }
    
    private func insertClient(_ client: Client) -> Bool {
        let insertSQL = "INSERT INTO clients (name, contact, phone, cnpj, address, value, due_date, is_recurring, frequency, selected_day) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertSQL, -1, &statement, nil) == SQLITE_OK {
            bindClientData(statement: statement, client: client, includeId: false)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                sqlite3_finalize(statement)
                return true
            }
        }
        
        sqlite3_finalize(statement)
        return false
    }
    
    private func updateClient(_ client: Client) -> Bool {
        guard let clientId = client.id else { return false }
        
        let updateSQL = "UPDATE clients SET name = ?, contact = ?, phone = ?, cnpj = ?, address = ?, value = ?, due_date = ?, is_recurring = ?, frequency = ?, selected_day = ? WHERE id = ?"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, updateSQL, -1, &statement, nil) == SQLITE_OK {
            bindClientData(statement: statement, client: client, includeId: false)
            sqlite3_bind_int(statement, 11, Int32(clientId))
            
            if sqlite3_step(statement) == SQLITE_DONE {
                sqlite3_finalize(statement)
                return true
            }
        }
        
        sqlite3_finalize(statement)
        return false
    }
    
    private func bindClientData(statement: OpaquePointer?, client: Client, includeId: Bool) {
        let startIndex = includeId ? 2 : 1
        
        sqlite3_bind_text(statement, Int32(startIndex), NSString(string: client.name).utf8String, -1, nil)
        sqlite3_bind_text(statement, Int32(startIndex + 1), NSString(string: client.contact).utf8String, -1, nil)
        sqlite3_bind_text(statement, Int32(startIndex + 2), NSString(string: client.phone).utf8String, -1, nil)
        sqlite3_bind_text(statement, Int32(startIndex + 3), NSString(string: client.cnpj).utf8String, -1, nil)
        sqlite3_bind_text(statement, Int32(startIndex + 4), NSString(string: client.address).utf8String, -1, nil)
        sqlite3_bind_double(statement, Int32(startIndex + 5), client.value)
        sqlite3_bind_text(statement, Int32(startIndex + 6), NSString(string: client.dueDate).utf8String, -1, nil)
        sqlite3_bind_int(statement, Int32(startIndex + 7), client.isRecurring ? 1 : 0)
        sqlite3_bind_text(statement, Int32(startIndex + 8), NSString(string: client.frequency).utf8String, -1, nil)
        
        if let day = client.selectedDay {
            sqlite3_bind_int(statement, Int32(startIndex + 9), Int32(day))
        } else {
            sqlite3_bind_null(statement, Int32(startIndex + 9))
        }
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
                                    frequency: frequency,
                                    selectedDay: selectedDay)
                
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
                              frequency: frequency,
                              selectedDay: selectedDay)
                
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
