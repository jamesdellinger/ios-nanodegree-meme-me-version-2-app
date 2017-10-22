//
//  MemeCollectionRowAndCellImageView.swift
//  MemeMe Version 2.0
//
//  Created by James Dellinger on 10/19/17.
//  Copyright © 2017 James Dellinger. All rights reserved.
//

import Foundation
import UIKit


// A custom image view class used in the cells in our meme collection view controller
// Needed this custom class in order to control the content mode of the cell's image view
// depending on the dimensions (portrait or landscape) of the memed image.
// The goal was to have both the top and bottom meme text visible inside the image displayed
// in the cell, regardless of whether the meme image was portrait or landscape
class MemeCollectionRowAndCellImageView: UIImageView {
    
    override var bounds: CGRect {
        didSet {
            adjustContentMode()
        }
    }
    
    override var image: UIImage? {
        didSet {
            adjustContentMode()
        }
    }
    
    
    // MARK: Adjusting content mode based on dimensions of meme image populating the
    // cell's image view
    func adjustContentMode() {
        guard let image = image else {
            return
        }
        // If image is landscape, display image in "aspect fill" content mode
        if image.size.width > image.size.height {
            contentMode = .scaleAspectFill
        // If image is portrait or square, display image in "aspect fit" content mode
        } else {
            contentMode = .scaleAspectFit
        }
    }
}
