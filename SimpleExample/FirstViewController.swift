//
//  FirstViewController.swift
//  SimpleExample
//
//  Created by Kam Hei Siu on 1/8/2017.
//  Copyright © 2017 Kam Hei Siu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FirstViewController: UIViewController {
    
    @IBOutlet weak var usernameTxtField: ValidateTextField!
    @IBOutlet weak var passwordTxtField: ValidateTextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let disposeBag = DisposeBag()
    let throttleInterval = 0.1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTxtChangeHandling()
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
    
    private func validate(username: String?) -> Bool {
        guard let name = username else { return false }
        return name.characters.count >= 6
    }
    
    private func setupPWTF() {
        passwordTxtField.layer.cornerRadius = passwordTxtField.frame.height / 2.0
    }
    
    private func validate(password: String?) -> Bool {
        guard let pw = password else { return false }
        return pw.characters.count >= 6
    }
    
    private func setupLoginBtn() {
        loginButton.layer.cornerRadius = loginButton.frame.height / 2.0
        loginButton.isEnabled = false
    }
    
    // MARK: RxCocoa
    
    // if both the text of the username and password have >=6 characters, we enable the button
    private func setupTxtChangeHandling() {
        let usernameValid = usernameTxtField
            .rx
            .text
            .throttle(throttleInterval, scheduler: MainScheduler.instance)
            .map{ self.validate(username: $0) }
        
        usernameValid
            .subscribe(onNext: { self.usernameTxtField.isValid = $0 })
            .addDisposableTo(disposeBag)
        
        let passwordValid = passwordTxtField
            .rx
            .text
            .throttle(throttleInterval, scheduler: MainScheduler.instance)
            .map{ self.validate(password: $0) }
        
        passwordValid
            .subscribe(onNext: { self.passwordTxtField.isValid = $0 })
            .addDisposableTo(disposeBag)
        
        let isLoginBtnEnabled = Observable.combineLatest(usernameValid, passwordValid) {
            $0 && $1
        }
        
        isLoginBtnEnabled
            .bind(to: self.loginButton.rx.isEnabled)
            .addDisposableTo(disposeBag)
    }
}

