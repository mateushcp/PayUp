//
//  PaymentCardType.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 15/06/25.
//

import UIKit

enum PaymentCardType {
    case incoming
    case transaction
    
    var iconName: String {
        switch self {
        case .incoming:
            return "calendarDollar"
        case .transaction:
            return "coins"
        }
    }
    
    var subtitle: String {
        switch self {
        case .incoming:
            return "A receber"
        case .transaction:
            return "Recebido"
        }
    }
}
