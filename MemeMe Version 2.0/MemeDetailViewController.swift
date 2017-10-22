//
//  MemeDetailViewController.swift
//  MemeMe Version 2.0
//
//  Created by James Dellinger on 10/19/17.
//  Copyright © 2017 James Dellinger. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    
    // Ensure that all orientations are supported
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown, .landscapeLeft, .landscapeRight]
    }
    
    // Hide the satus bar
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    // MARK: Properties
    
    // The meme image that will be displayed
    var image: UIImage?
    
    // MARK: Outlets
    // The image view where the meme image will be displayed
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView!.image = image
        
        // This is the details view so we want to keep the tab bar hidden
        // Users will navigate to whichever previous screen they were on
        // (table view or collection view) either by tapping cancel or automatically
        // after they share a meme
        self.tabBarController?.tabBar.isHidden = true
        
        // Also make sure navigation bar is hidden, so that user can
        // access share button as well as cancel button, top pop
        // back to previous (table or collection) view controller
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Make the tab bar reappear when this view is dismissed
        self.tabBarController?.tabBar.isHidden = false
        
        // Also make sure navigation bar is unhidden to prepare for
        // the view returning to the previous (table or collection)
        // view controller
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: Share the meme image
    @IBAction func shareImage(_ sender: Any) {
        let activityController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        // Present the activity controller
        self.present(activityController, animated: true, completion: nil)
        
        // If user completes an activity inside activity controller, such as sharing,
        // immediately pop back to previous screen (meme table or collection screen).
        activityController.completionWithItemsHandler = {(activityType: UIActivityType?, completed:Bool, returnedItems:[Any]?, error: Error?) in
            // But if user cancels without completing an activity in activity controller, then
            // view should stay on the current meme detail screen
            if !completed {
                return
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    // Dismissing the meme detail view
    // Pop to previous screen (either meme table or collection view) when user taps Cancel button
    @IBAction func cancel() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
