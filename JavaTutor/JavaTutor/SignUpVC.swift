//
//  SignUpVC.swift
//  JavaTutor
//
//  Created by Daniel Carns on 3/11/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

var ref: DatabaseReference!

class SignUpVC: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pass1Field: UITextField!
    @IBOutlet weak var pass2Field: UITextField!
   
    
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBAction func touchNameField(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    @IBAction func backgroundTap(_ sender: Any?) {
        self.view.endEditing(true)
    }
    
    //DOES NOT CURRENTLY WORK
    //Dismiss keyboard when return button is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameField.resignFirstResponder()
        emailField.resignFirstResponder()
        pass1Field.resignFirstResponder()
        pass2Field.resignFirstResponder()

        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pass1Field.textContentType = .oneTimeCode
        pass2Field.textContentType = .oneTimeCode
        
        
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
        ref = Database.database().reference()
        var emailID : String = email
       
        if let index = email.firstIndex(of: ".") {
            emailID.remove(at: index)
        }
        
        Auth.auth().createUser(withEmail: email, password: pass) { authResult, error in
            
            guard let authResult = authResult, error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            ref.child("users").child(emailID).child("name").setValue(self.nameField.text!)
            ref.child("users").child(emailID).child("stats").child("questionsAns").setValue(0)
            ref.child("users").child(emailID).child("stats").child("correctPct").setValue(0.0)

            print("\(String(describing: authResult.email)) created")
            //strongSelf.navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        
       
        
        if nameField.text != "" {
            if (emailField.text?.contains("@"))! {
                if (pass1Field.text == pass2Field.text && (pass1Field.text?.count)! >= 6) {
                    createUser(email: emailField.text!, pass: pass1Field.text!)
                    performSegue(withIdentifier: "signedUp", sender: nil)
                } else {
                    //let alert = UIAlertController(title: "Alert", message: "Passwords do not match.", preferredStyle: UIAlertController.Style.alert)
                    //self.present(alert, animated: true, completion: nil)
                }
            } else {
                //let alert = UIAlertController(title: "Alert", message: "Please enter a valid email address.", preferredStyle: UIAlertController.Style.alert)
                //self.present(alert, animated: true, completion: nil)
            }
            
            
        } else {
            //let alert = UIAlertController(title: "Alert", message: "Please enter your first name.", preferredStyle: UIAlertController.Style.alert)
            //self.present(alert, animated: true, completion: nil)
        }
        
        
    
    }
   
    @IBAction func toSignIn(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toLogin", sender: nil)
        
    }
    
}
