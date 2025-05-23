//
//  UIView+Ext.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 21/04/25.
//

import Foundation
import UIKit

extension UIView {
    func animateFadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0) {
        self.alpha = 0
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut) {
            self.alpha = 1
        }
    }
}
