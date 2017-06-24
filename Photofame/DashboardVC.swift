//
//  DashboardVC.swift
//  Photofame
//
//  Created by Appit on 6/24/17.
//  Copyright © 2017 Appit. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {

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
    
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial configuration
        hideEditorsView()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PhotoStreamViewController" {
            
            // Set references
           let  photoStreamViewController = segue.destination as! PhotoStreamViewController
            photoStreamViewController.dashboardViewController = self
        }
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
    
    // MARK: - 
    
    func showLoadMore() {
        
        self.loadMoreActivity.startAnimating()
        self.loadMoreActivity.isHidden = false
    }
    
    
    func hideLoadMore() {
        
        self.loadMoreActivity.stopAnimating()
    }
    
}
