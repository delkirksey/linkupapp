//
//  LoginViewController.swift
//  LinkUp
//
//  Created by Del Shawn Kirksey on 8/15/17.
//  Copyright © 2017 Del Shawn Kirksey. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //setUpVideoBackground()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        
        if self.emailField.text == "" || self.passwordField.text == "" {
            //  Alert the user of an error due to empty fields
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!) { (user, error) in
                if error == nil {
                    
                    //  Print into the console if successfully logged in
                    print("You have successfully logged in.")
                    
                    //  Go to the HomeViewController
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "UITabBarController")
                    self.present(vc, animated: true, completion: nil)
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
//                    self.present(vc!, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    func setUpVideoBackground() {
        let videoURL: NSURL = Bundle.main.url(forResource: "rollercoaster", withExtension: "mp4")! as NSURL
        
        player = AVPlayer(url: videoURL as URL)
        player?.actionAtItemEnd = .none
        player?.isMuted = true
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.zPosition = -1
        
        playerLayer.frame = view.frame
        
        view.layer.addSublayer(playerLayer)
        
        player?.play()
        
        //  loop video
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.loopVideo), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    func loopVideo() {
        player?.seek(to: kCMTimeZero)
        player?.play()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
