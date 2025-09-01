//
//  DaySelectorViewModel.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 01/05/25.
//

import Foundation

final class DaySelectorViewModel {
    let days = ["SEG", "TER", "QUA", "QUI", "SEX", "SAB", "DOM"]
    private let calendar = Calendar.current
    private var currentSelectedIndex: Int
    
    var onDaySelected: ((Int) -> Void)?
    var selectedIndex: Int {
        let weekday = calendar.component(.weekday, from: Date())
        return (weekday + 5) % 7
    }
    
    
    init() {
        let weekday = calendar.component(.weekday, from: Date())
        currentSelectedIndex = (weekday + 5) % 7
    }
    
    func selectDay(at index: Int) {
        currentSelectedIndex = index
        onDaySelected?(index)
    }
    
    func getSelectedDay() -> Int? {
        return currentSelectedIndex + 1
    }
}
