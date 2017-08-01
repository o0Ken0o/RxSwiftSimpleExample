//
//  ValidateTextField.swift
//  SimpleExample
//
//  Created by Kam Hei Siu on 1/8/2017.
//  Copyright © 2017 Kam Hei Siu. All rights reserved.
//

import UIKit

class ValidateTextField: UITextField {
    var isResignedB4: Bool = false
    var isValid: Bool = false {
        didSet {
            changeBgColor()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func changeBgColor() {
        if isResignedB4 {
            self.backgroundColor = isValid ? .white : .red
        }
    }
    
    override func resignFirstResponder() -> Bool {
        isResignedB4 = true
        return super.resignFirstResponder()
    }
}
