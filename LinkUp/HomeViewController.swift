//
//  HomeViewController.swift
//  LinkUp
//
//  Created by Del Shawn Kirksey on 8/15/17.
//  Copyright © 2017 Del Shawn Kirksey. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "LogIn")
                present(vc, animated: true, completion: nil)
            } catch let error as NSError {
                print (error.localizedDescription)
            }
        }
    }
    
    @IBAction func menuBtnTapped(_ sender: Any) {
        
    }
}
