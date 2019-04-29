//
//  LoginScreenVC.swift
//  JavaTutor
//
//  Created by Emily Wasylenko on 2/22/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit
import Firebase

class LoginScreenVC: UIViewController, UITextFieldDelegate {
    let repo = StudentRepo.instance
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBAction func touchNameField(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    @IBAction func backgroundTap(_ sender: Any?) {
        self.view.endEditing(true)
    }
    
    //DOES NOT CURRENTLY WORK
    //Dismiss keyboard when return button is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let gen = QGen()
        print(gen.getQuestion(module: 2))
        
        emailField.attributedPlaceholder = NSAttributedString(string: "Username",
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
        let email : String = emailField.text!
        let pass : String = passwordField.text!
        
        Auth.auth().signIn(withEmail: email, password: pass) { [weak self] user, error in
            guard let strongSelf = self else { return }
            self?.performSegue(withIdentifier: "loggedIn", sender: nil)
        }
        
        repo.initAfterLogin(username: email)
    }
    
    @IBAction func toSignUp(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toSignUp", sender: nil)
        
    }
}
