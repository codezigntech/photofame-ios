//
//  PhotographerVC.swift
//  Photofame
//
//  Created by Appit on 6/25/17.
//  Copyright © 2017 Appit. All rights reserved.
//

import UIKit

class PhotographerVC: UIViewController {

    
    // MARK: - Properties
    
    
    
    // MARK: - Outlets
    @IBOutlet weak var gridContainerView: UIView!
    @IBOutlet weak var editorsContainerView: UIView!
    
    @IBOutlet weak var popularButton: UIButton!
    @IBOutlet weak var editorButton: UIButton!
    
    @IBOutlet weak var popularLineView: UIView!
    @IBOutlet weak var editorsLineView: UIView!
    
    @IBOutlet weak var loadMoreActivity: UIActivityIndicatorView!
    
    
    // MARK: - Actions
    
    @IBAction func menuAction(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
//        let menuVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
//        
//        self.present(menuVC, animated: true, completion: nil)
    }
    
    
    @IBAction func popularAction() {
        
        DispatchQueue.main.async {
            self.showPopularView()
            self.hideEditorsView()
        }
    }
    
    @IBAction func editorsAction(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            self.showEditorsView()
            self.hidePopularView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial configuration
        hideEditorsView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MAKR: -
    
    func hideEditorsView() {
        
        self.editorButton.alpha = 0.56
        self.editorsLineView.isHidden = true
        self.editorsContainerView.isHidden = true
    }
    
    func showEditorsView() {
        
        self.editorButton.alpha = 1.0
        self.editorsLineView.isHidden = false
        self.editorsContainerView.isHidden = false
    }
    
    func hidePopularView() {
        
        self.popularButton.alpha = 0.56
        self.popularLineView.isHidden = true
        self.gridContainerView.isHidden = true
    }
    
    func showPopularView() {
        
        self.popularButton.alpha = 1.0
        self.popularLineView.isHidden = false
        self.gridContainerView.isHidden = false
    }


}
