//
//  LoginViewController.swift
//  A.W.M.T.Amunugama-cobsccomp191p015
//
//

import UIKit


class LoginViewController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapSignIn(_ sender: Any) {
        
        var email = self.txtEmail.text
        var pwd = self.txtPassword.text
        if (email ?? "").isEmpty  {
            Utilities.errorToast(error: "Email is required!")
        } else if (pwd ?? "").isEmpty  {
            Utilities.errorToast(error: "Password is required!")
        } else {
            Utilities.showLoader()
            APIClient.shared.login(email: email!, password: pwd!) { (status, response) in
                Utilities.hideLoader()
                if (status == APIClient.APIResponseStatus.Success) {
                    if let token = response?.token {
                        Utilities.saveToken(token: token)
                        if let name = response?.user?.name {
                            Utilities.saveName(name: name)
                        }
                        let homeVC = UIStoryboard.mainStoryboard().instantiateViewController(identifier: "HomeTabController") as? UITabBarController
                        self.view.window?.rootViewController = homeVC
                    } else {
                        Utilities.errorToast(error: "Login Failed!")
                    }
                } else if (status == APIClient.APIResponseStatus.InternalServerError){
                    Utilities.errorToast(error: (response?.message)!)
                } else {
                    Utilities.errorToast(error: "Login Failed")
                }
            }
            
        }
        
    }
    
    @IBAction func didTapRegister(_ sender: Any) {
        let regVC = UIStoryboard.loginStoryboard().instantiateViewController(withIdentifier: "RegisterVC") as? RegisterViewController
        UIApplication.shared.keyWindow?.rootViewController = regVC
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txtEmail {
            self.txtEmail.resignFirstResponder()
        }
        if textField == self.txtPassword {
            self.txtPassword.resignFirstResponder()
        }
        return true
    }
    
}
