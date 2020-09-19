//
//  RegisterViewController.swift
//  A.W.M.T.Amunugama-cobsccomp191p015
//
//

import UIKit

class RegisterViewController: UITableViewController , UITextFieldDelegate{
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtRole: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func didTapSignUp(_ sender: Any) {
        var name = self.txtName.text
        var mobile = self.txtMobile.text
        var email = self.txtEmail.text
        var role = self.txtRole.text
        var pwd = self.txtPassword.text
        
        if (name ?? "").isEmpty {
            Utilities.errorToast(error: "Name is required!")
        } else if (mobile ?? "").isEmpty {
            Utilities.errorToast(error: "Mobile is required!")
        } else if (email ?? "").isEmpty {
            Utilities.errorToast(error: "Email is required!")
        } else if (role ?? "").isEmpty {
            Utilities.errorToast(error: "Role is required!")
        } else if (pwd ?? "").isEmpty {
            Utilities.errorToast(error: "Password is required!")
        } else {
            Utilities.showLoader()
            APIClient.shared.signup(email: email!, name: name!, role: role!, password: pwd!, phone: mobile!) { (status, response) in
                Utilities.hideLoader()
                if (status == APIClient.APIResponseStatus.Success) {
                    Utilities.messageToast(message: "Succussfully regsitered!")
                    let loginVC = UIStoryboard.loginStoryboard().instantiateViewController(withIdentifier: "LoginVC") as? LoginViewController
                    UIApplication.shared.keyWindow?.rootViewController = loginVC
                } else if (status == APIClient.APIResponseStatus.InternalServerError){
                    Utilities.errorToast(error: (response?.message)!)
                } else {
                    Utilities.errorToast(error: "Register Failed")
                }
            }
            
        }
    }
    
    @IBAction func didTapSignIn(_ sender: Any) {
        let loginVC = UIStoryboard.loginStoryboard().instantiateViewController(withIdentifier: "LoginVC") as? LoginViewController
        UIApplication.shared.keyWindow?.rootViewController = loginVC
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txtEmail {
            self.txtEmail.resignFirstResponder()
        }
        if textField == self.txtName {
            self.txtName.resignFirstResponder()
        }
        if textField == self.txtMobile {
            self.txtMobile.resignFirstResponder()
        }
        if textField == self.txtRole {
            self.txtRole.resignFirstResponder()
        }
        if textField == self.txtPassword {
            self.txtPassword.resignFirstResponder()
        }
        return true
    }
}
