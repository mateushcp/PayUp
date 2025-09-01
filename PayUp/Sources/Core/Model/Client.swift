//
//  Client.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 09/08/25.
//

import Foundation

struct Client {
    let id: Int?
    let name: String
    let contact: String
    let phone: String
    let cnpj: String
    let address: String
    let value: Double
    let dueDate: String
    let isRecurring: Bool
    let frequency: String
    let selectedDay: Int?
    
    init(id: Int? = nil, name: String, contact: String, phone: String, cnpj: String, address: String, value: Double, dueDate: String, isRecurring: Bool, frequency: String, selectedDay: Int? = nil) {
        self.id = id
        self.name = name
        self.contact = contact
        self.phone = phone
        self.cnpj = cnpj
        self.address = address
        self.value = value
        self.dueDate = dueDate
        self.isRecurring = isRecurring
        self.frequency = frequency
        self.selectedDay = selectedDay
    }
}