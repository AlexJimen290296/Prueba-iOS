//
//  CustomButton.swift
//  Prueba iOS
//
//  Created by Ada Palazuelos on 14/07/20.
//  Copyright © 2020 JAJC. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func setBorderStyle() {
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.backgroundColor = UIColor(named: "ColorPrimaryDark")?.cgColor
        self.setTitleColor(UIColor.white, for: .normal)
    }
}
