//
//  SignUpVC.swift
//  JavaTutor
//
//  Created by Daniel Carns on 3/11/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pass1Field: UITextField!
    @IBOutlet weak var pass2Field: UITextField!
   
    
    var handle: AuthStateDidChangeListenerHandle?
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        nameField.attributedPlaceholder = NSAttributedString(string: "Name",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        emailField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        pass1Field.attributedPlaceholder = NSAttributedString(string: "Password",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        pass2Field.attributedPlaceholder = NSAttributedString(string: "Confirm Password",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //Auth.auth().removeStateDidChangeListener(handle!)
        
    }
    
    func createUser(email: String, pass: String) {
        
        
        Auth.auth().createUser(withEmail: email, password: pass) { authResult, error in
            
            guard let authResult = authResult, error == nil else {
                print(error!.localizedDescription)
                return
            }
            print("\(String(describing: authResult.email)) created")
            //strongSelf.navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        
       
        
        if nameField.text != "" {
            
            

            
            if (emailField.text?.contains("@"))! {
                
                
                if (pass1Field.text == pass2Field.text) {
                    createUser(email: emailField.text!, pass: pass1Field.text!)
                    performSegue(withIdentifier: "signedUp", sender: nil)
                } else {
                    let alert = UIAlertController(title: "Alert", message: "Passwords do not match.", preferredStyle: UIAlertController.Style.alert)
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Alert", message: "Please enter a valid email address.", preferredStyle: UIAlertController.Style.alert)
                self.present(alert, animated: true, completion: nil)
            }
            
            
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please enter your first name.", preferredStyle: UIAlertController.Style.alert)
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
        
    }
   
    
}