//
//  CompanyViewModel.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 11/05/25.
//

import Foundation

final class CompanyViewModel {
    var companies: [CompanyItemModel] = []
    
    init(companies: [CompanyItemModel]) {
        self.companies = companies
    }
    
    func updateCompanies(_ companies: [CompanyItemModel]) {
        self.companies = companies
    }
}
