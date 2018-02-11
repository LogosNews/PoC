//
//  ViewController.swift
//  PoC
//
//  Created by Siddharth Pandiya on 2/10/18.
//  Copyright © 2018 Siddharth Pandiya. All rights reserved.
//

import UIKit
import FacebookLogin

import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI

// Check Google plist, get URL-ID
// Then go the app info stuff, Info tab
// In URL Types, paste to URL Schemes

// FIRAuth -> Auth
// FIRUser -> User
// FIRDatabase -> Database


class ViewController: UIViewController {
    
    // -------------------
    var ref: DatabaseReference!  // Remove FIR
    fileprivate var _refHandle: DatabaseHandle!   // Remove FIR
    fileprivate var _authHandle: AuthStateDidChangeListenerHandle!  // Remove FIR?
    var user: User?
    var displayName = "Anonymous"
    // -------------------
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        configureAuth()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Config
    
    // -------------------
    func configureAuth() {
        let provider: [FUIAuthProvider] = [FUIGoogleAuth()]
        FUIAuth.defaultAuthUI()?.providers = provider
        
        _authHandle = Auth.auth().addStateDidChangeListener { (auth: Auth, user: User?) in // can remove the q-mark
            // check if there is a current user
            if let activeUser = user {
                // check if the current app user is User
                self.user = activeUser
                self.signedInStatus(isSignedIn: true)
                let name = user!.email!.components(separatedBy: "@")[0]
                self.displayName = name
            } else {
                // user must sign in
                self.signedInStatus(isSignedIn: false)
                self.loginSession()
            }
        }
        // TODO: configure firebase authentication
    }
    
    func configureDatabase() {
        ref = Database.database().reference()
        /*
        _refHandle = ref.child("messages").observe(.childAdded) { (snapshot: FIRDataSnapshot) in  // remove FIR
            self.messages.append(snapshot)
            self.messagesTable.insertRows(at: [IndexPath(row: self.messages.count - 1, section: 0)], with: .automatic)
            self.scrollToBottomMessage()
        }
 */
        // TODO: configure database to sync messages
    }
 
    // ---------------------
    
    // ---------------------
    deinit {
        Auth.auth().removeStateDidChangeListener(_authHandle)
    }
    
    // MARK: Sign In and Out
    
    func signedInStatus(isSignedIn: Bool) {
        /*
        signInButton.isHidden = isSignedIn
        signOutButton.isHidden = !isSignedIn
        messagesTable.isHidden = !isSignedIn
        messageTextField.isHidden = !isSignedIn
        sendButton.isHidden = !isSignedIn
        imageMessage.isHidden = !isSignedIn
        
        */
        if (isSignedIn) {
            configureDatabase()
            // TODO: Set up app to send and receive messages when signed in
        }
    }
    
    func loginSession() {
        let authViewController = FUIAuth.defaultAuthUI()!.authViewController()
        self.present(authViewController, animated: true, completion: nil)
    }


}

