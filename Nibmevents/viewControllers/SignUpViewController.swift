//
//  SignUpViewController.swift
//  Nibmevents
//
//  Created by nisal jayathilaka on 2/18/20.
//  Copyright © 2020 nisal jayathilaka. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var profpic: UIImageView!
    @IBOutlet weak var fistnametxt: UITextField!
    @IBOutlet weak var lastnametxt: UITextField!
    @IBOutlet weak var emailtxt: UITextField!
    @IBOutlet weak var phonumtxt: UITextField!
    @IBOutlet weak var passtxt: UITextField!
    @IBOutlet weak var errorLable: UILabel!
    @IBOutlet weak var signupbtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
       setUpElements()
        // Do any additional setup after loading the view.
    }
    func setUpElements(){
        errorLable.alpha=0
    }
    
    func validateFields() -> String? {
        
        if fistnametxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastnametxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailtxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            phonumtxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passtxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            
        {
            return "please fill in all fields."
        }
        
        let cleanedPassword = passtxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false
        {
            return "  password least 8 carackters, special character and a number"
        }
        
        
        return nil
    }
    
    
    
    

    @IBAction func SignUpTapped(_ sender: Any) {
        
        let error = validateFields()
        if error != nil
        {
            showError(error!)
        }
            
        else
        {
            let firstName = fistnametxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastnametxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailtxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let phoneNumber = phonumtxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passtxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                if err != nil
                {
                    self.showError("error cretaing user")
                }
                else
                {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data:
                        ["fisrtname":firstName,
                         "lastname":lastName,
                         "email":email,
                         "phonnumber":phoneNumber,
                         "uid": result!.user.uid])
                    {
                        (error) in
                        
                        if error != nil {
                            self.showError("error saving user data")
                        }
                    }
                    ///////////
                    let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
                    
                    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
                    loadingIndicator.hidesWhenStopped = true
                    loadingIndicator.style = UIActivityIndicatorView.Style.gray
                    loadingIndicator.startAnimating();
                    
                    alert.view.addSubview(loadingIndicator)
                    self.present(alert, animated: true, completion: nil)
                    
                    alert.dismiss(animated: false, completion: nil)
                    
                    //////////////////
                    self.movetohome()
                    
                    
                }
            }
        }
        
        
        
    }
    
    
    func showError(_ message:String) {
        self.errorLable.alpha = 1
        self.errorLable.text = message
    }
    func movetohome() {
        
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constans.Storyboard.homeViewController) as?
        HoViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
        
    }
    

}
