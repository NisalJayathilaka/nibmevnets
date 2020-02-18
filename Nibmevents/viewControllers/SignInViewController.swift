//
//  SignInViewController.swift
//  Nibmevents
//
//  Created by nisal jayathilaka on 2/18/20.
//  Copyright © 2020 nisal jayathilaka. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailtxt: UITextField!
    @IBOutlet weak var passtxt: UITextField!
    @IBOutlet weak var signin: UIButton!
    @IBOutlet weak var errorLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupelments()
        // Do any additional setup after loading the view.
    }
    
    func setupelments() {
        errorLable.alpha=0
    }
    
    
    @IBAction func SignInTapped(_ sender: Any) {
        
        let email = emailtxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passtxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                self.errorLable.alpha = 1
                self.errorLable.text = error!.localizedDescription
            }
            else
            {
                
                let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
                
                let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
                loadingIndicator.hidesWhenStopped = true
                loadingIndicator.style = UIActivityIndicatorView.Style.gray
                loadingIndicator.startAnimating();
                
                alert.view.addSubview(loadingIndicator)
                self.present(alert, animated: true, completion: nil)
                
                
                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: Constans.Storyboard.homeViewController) as? HoViewController
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
                
                alert.dismiss(animated: false, completion: nil)
            }
        }
        
        
    }
    

}
