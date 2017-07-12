//
//  ViewController.swift
//  UdemyDevslopesSocial
//
//  Created by Lily Hofman on 7/10/17.
//  Copyright © 2017 Lily Hoffman. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class SignInVC: UIViewController {

    @IBOutlet var emailField: FancyField!
    @IBOutlet var passwordField: FancyField!
    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text{
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil{
                    print("Login successful")
                }else{
                    print("Login unsuccessful")
                    if user == nil{
                        print("creating user...")
                        Auth.auth().createUser(withEmail: email, password: password, completion: nil)
                    }else{
                        print("user signed in")
                    }
                }
            })
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookButtonTapped(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self, handler: { (result, error) in
            if error != nil{
                print("ERROR: unable to login with credentials")
            }else if result?.isCancelled == true{
                print("ERROR: user cancelled fb auth")
            }else{
                print("Facebook authentication successful")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.facebookAuth(credential)
            }
        })
    }

    
    func facebookAuth(_ credential: AuthCredential){
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                print("ERROR: \(error)")
                return
            }
            print("Firebase authentication successful")
        }
    }
}

