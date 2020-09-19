//
//  InstructionsViewController.swift
//  A.W.M.T.Amunugama-cobsccomp191p015
//
//

import UIKit

class InstructionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func didTapLogout(_ sender: Any) {
        Utilities.saveToken(token: "")
        let loginVc = UIStoryboard.loginStoryboard().instantiateViewController(identifier: "LoginVC") as? LoginViewController
               self.view.window?.rootViewController = loginVc
    }
    
}
