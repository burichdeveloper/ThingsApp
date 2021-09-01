//
//  LoginViewController.swift
//  Assignment3
//
//  Created by Rodrigo Dominguez burich on 2021-07-30.
//

import UIKit

class LoginViewController: UIViewController {

    var autoLogin = true
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    @IBOutlet weak var loginBtnOutlet: UIButton!
    
    @objc func applicationWillEnterForeground(notificaton: NSNotification) {
        let defaults = UserDefaults.standard
        defaults.synchronize()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillEnterForeground(notificaton:)), name: UIApplication.willEnterForegroundNotification, object: app)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtnOutlet.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        usernameTextField.text = defaults.string(forKey: "name_preference")
        passwordTextField.text = defaults.string(forKey: "password_preference")
        rememberMeSwitch.isOn = defaults.bool(forKey: "rememberme_preference")
        if usernameTextField.text != nil &&
            passwordTextField.text != nil &&
            rememberMeSwitch.isOn &&
            autoLogin {
            self.performSegue(withIdentifier: "loggedOn", sender: self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if usernameTextField.text != nil &&
            passwordTextField.text != nil &&
            rememberMeSwitch.isOn &&
            autoLogin {
            self.performSegue(withIdentifier: "loggedOn", sender: self)
        }
    }
    

   
    @IBAction func loginPressed(_ sender: Any) {
        if rememberMeSwitch.isOn {
            let defaults = UserDefaults.standard
            defaults.set(usernameTextField.text, forKey: "username_preference")
            defaults.set(passwordTextField.text, forKey: "password_preference")
            defaults.set(rememberMeSwitch.isOn, forKey: "rememberme_preference")
            print("login settings saved")
        } else {
            let defaults = UserDefaults.standard
            defaults.set("", forKey: "username_preference")
            defaults.set("", forKey: "password_preference")
            defaults.set(false, forKey: "rememberme_preference")
            print("login settings cleared")
        }
    }
    
    

    
}
