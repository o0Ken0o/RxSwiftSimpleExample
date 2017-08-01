//
//  FirstViewController.swift
//  SimpleExample
//
//  Created by Kam Hei Siu on 1/8/2017.
//  Copyright © 2017 Kam Hei Siu. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupUsernameTF()
        setupPWTF()
        setupLoginBtn()
    }
    
    private func setupUsernameTF() {
        usernameTxtField.layer.cornerRadius = usernameTxtField.frame.height / 2.0
    }
    
    private func setupPWTF() {
        passwordTxtField.layer.cornerRadius = passwordTxtField.frame.height / 2.0
    }
    
    private func setupLoginBtn() {
        loginButton.layer.cornerRadius = loginButton.frame.height / 2.0
        loginButton.isEnabled = false
    }
    
    

}

