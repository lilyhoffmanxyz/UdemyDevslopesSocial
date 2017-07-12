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

