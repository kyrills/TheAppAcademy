//
//  UIViewExtension.swift
//  TransitiongPopupView
//
//  Created by ben on 26/10/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setRadiusWithShadow(_ radius: CGFloat? = nil) {
        self.layer.cornerRadius = radius ?? self.frame.width / 2
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.7
        self.layer.masksToBounds = false
    }
}
