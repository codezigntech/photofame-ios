//
//  MenuVC.swift
//  Photofame
//
//  Created by Appit on 6/25/17.
//  Copyright © 2017 Appit. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    
    
    // MARK: - Properties
    
    // MARK: - Outlets
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var photographerButton: UIButton!
    
    
    
    // MARK: - Actions
    @IBAction func closeAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func userAction(_ sender: UIButton) {
        
        photographerButton.setImage(UIImage(named: "photographer"), for: .normal)
        userButton.setImage(UIImage(named: "user"), for: .normal)
        
//        self.dismiss(animated: true, completion: nil)
        
        let dashboardVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        
        self.present(dashboardVC, animated: true, completion: nil)
        
    }
    
    @IBAction func photographerAction(_ sender: UIButton) {
        
        photographerButton.setImage(UIImage(named: "camera-active"), for: .normal)
        userButton.setImage(UIImage(named: "user-inactive"), for: .normal)
        
        
        let photographerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotographerVC") as! PhotographerVC
        
        self.present(photographerVC, animated: true, completion: nil)
    }
    
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.closeButton.layer.masksToBounds = true
        self.closeButton.layer.cornerRadius = self.closeButton.frame.height / 2.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
