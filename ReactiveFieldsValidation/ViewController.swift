//
//  ViewController.swift
//  ReactiveFieldsValidation
//
//  Created by Sachin Daingade on 14/02/21.
//

import UIKit
import Bond
import ReactiveKit

class ViewController: UITableViewController {
    
    @IBOutlet weak var userNameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    // tips
    @IBOutlet weak var userNameTip: UILabel!
    @IBOutlet weak var emailTip: UILabel!
    @IBOutlet weak var passwordTip: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        userNameTextfield.reactive.text.map{$0!.isValidForType(type: .userName)}.observeNext{ [unowned self] success in
            self.userNameTip.isHidden = success ? true : false
            if let name = self.userNameTextfield.text, name.count > 0, !success {
                self.userNameTip.textColor = UIColor.customColor(.errorRed)
            }
        }.dispose(in: bag)
        
        emailTextfield.reactive.text.map{$0!.isValidForType(type: .email)}.observeNext{ [unowned self] success in
            self.emailTip.isHidden = success ? true : false
            if let email = self.emailTextfield.text, email.count > 0, !success {
                self.emailTip.textColor = UIColor.customColor(.errorRed)
            }
        }.dispose(in: bag)
        
        
        passwordTextfield.reactive.text.map{$0!.isValidForType(type: .password)}.observeNext{ [unowned self] success in
            self.passwordTip.isHidden = success ? true : false
            if let password = self.passwordTextfield.text, password.count > 0, !success {
                self.passwordTip.textColor = UIColor.customColor(.errorRed)
            }
        }.dispose(in: bag)
        
        
        combineLatest(userNameTextfield.reactive.text, emailTextfield.reactive.text, passwordTextfield.reactive.text).map {  (user , email, password ) -> Bool in
            return user!.isValidForType(type: .userName) &&  email!.isValidForType(type: .email) && password!.isValidForType(type: .password)
        }.observeNext{ [unowned self] isValid in
            self.saveButton.isEnabled = isValid
            self.saveButton.alpha = isValid ? 1.0 : 0.4
            
        }.dispose(in: bag)
        
        
        saveButton.reactive.tap.observeNext{ [unowned self] in
            let user = User(userName: userNameTextfield.text!, email: emailTextfield.text!, password: passwordTextfield.text!)
            print(user)
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return }
            let mainState = appDelegate.mainState
            mainState.input.action.send(.getAllEmployees)
            let employeeVC = EmployeesViewController.makeViewController(mainState: mainState)
            self.navigationController?.pushViewController(employeeVC, animated: true)
            
        }.dispose(in: bag)
    }
}



