//
//  MemeTableViewController.swift
//  MemeMe Version 2.0
//
//  Created by James Dellinger on 10/19/17.
//  Copyright © 2017 James Dellinger. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties
    // An array of memes
    var memes: [Meme]!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // The array of memes that the user has created
        // Stored in the AppDelegate class
        memes = appDelegate.memes
    }
    
    // MARK: Table methods
   
    // Get the number of rows (memes) that must appear in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // The number of memes that the user has saved, which is the number
        // of rows that will be displayed in this table
        return memes.count
    }
    
    // Display each row (meme) with the proper cell info inside it
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Retrieve the meme to be displayed in the row
        let meme: Meme = memes[(indexPath as NSIndexPath).row]
        
        // Dequeue each row and set the image and text inside it
        // Row text label will be the top text of each meme
        // Row image will be the memed image
        let row = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell") as! MemeTableViewCell
        // Set the text of the row to the meme's top and bottom text
        row.tableRowLabel?.text = "\(meme.topText) / \(meme.bottomText)"
        
        // And set the image in the row to the complete meme's image
        row.tableRowImageView?.image = meme.memedImage

        return row
    }
    
    // Push the Meme Detail View Controller displaying the selected
    // meme's details when the user taps on that meme's row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        // Get the Meme Detail View Controller from the Storyboard
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController")as! MemeDetailViewController
        
        // Retrieve the meme to be displayed in the Meme Detail View Controller
        let meme: Meme = memes[(indexPath as NSIndexPath).row]
        
        // Set the meme image that will be displayed in the Meme Detail View Controller
        controller.image = meme.memedImage
        
        // Push the new controller onto the stack
        self.navigationController!.pushViewController(controller, animated: true)
    }
}
