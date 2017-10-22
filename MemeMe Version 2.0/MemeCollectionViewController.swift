//
//  MemeCollectionViewController.swift
//  MemeMe Version 2.0
//
//  Created by James Dellinger on 10/19/17.
//  Copyright © 2017 James Dellinger. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    // MARK: Collection View Flow Layout outlet
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // MARK: Properties
    // An array of memes
    var memes: [Meme]!
    
    // MARK: Defining the view flow layout
    // Call this function from viewDidLoad to get initial flow layout for
    // collection view controller, or call from closure of viewWillTRansition to
    // get updated flow layout when orientation changes from portrait to landscape
    // or vice-versa
    func setCollectionFlowLayout(_ currentDeviceOrientation: String) {
        
        let space: CGFloat = 3.0
        
        var dimension: CGFloat { get {
            if currentDeviceOrientation == "Portrait" {
                // Keeps column spacing uniform if device is in portrait orientation
                return (view.frame.size.width - (2 * space)) / 3.0
            } else  {
                // Keeps column spacing uniform if device is in landscape orientation
                return (view.frame.size.width - (4 * space)) / 5.0
            }}
        }
        
        flowLayout?.minimumInteritemSpacing = space
        flowLayout?.minimumLineSpacing = space
        flowLayout?.itemSize = CGSize(width: dimension, height: dimension)
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // The array of memes that the user has created
        // Stored in the AppDelegate class
        memes = appDelegate.memes
        
        // Get collection flow layout collection view controller first loads
        if UIDevice.current.orientation.isPortrait {
            setCollectionFlowLayout("Portrait")
        } else {
            setCollectionFlowLayout("Landscape")
        }
    }
    
    // Update collection flow layout if device orientation changes while
    // collection view is visible
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        // Use a closure so that current orientation is detected only
        // after orientation has completed its change
        coordinator.animate(alongsideTransition: nil) { _ in
            if UIDevice.current.orientation.isPortrait {
                self.setCollectionFlowLayout("Portrait")
            } else {
                self.setCollectionFlowLayout("Landscape")
            }
        }
    }
    
    // Get the number of cells (memes) that must appear in the collection
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // The number of memes that the user has saved, which is the number
        // of cells that will be displayed in this collection
        return memes.count
    }
    
    // Dequeue cells as they are displayed in the meme collection view controller
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // The cell the be dequeued
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        
        // Get the meme whose image will be displayed inside its cell in the collection
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // And then set the image display view in the meme collection cell
        cell.collectionCellImageView?.image = meme.memedImage
        
        return cell
    }
    
    // Push the view to the meme detail view controller when the user selects a
    // meme inside the collection view
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        // Grab the Meme Detail View Controller from Storyboard
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        // Get the meme that the user selected, so it can be displayed inside its cell
        // in the collection
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Populate view controller with data from the selected item
        controller.image = meme.memedImage
        
        // Present the view controller using navigation
        navigationController!.pushViewController(controller, animated: true)
    }
}
