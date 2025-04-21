//
//  UIView+Ext.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 21/04/25.
//

import Foundation
import UIKit

extension UIView {
    func animateMoveOut(to point: CGPoint, duration: TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut) {
            self.center = point
            self.alpha = 0
        }
    }
}
