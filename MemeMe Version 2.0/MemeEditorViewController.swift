//
//  MemeEditorViewController.swift
//  MemeMe Version 2.0
//
//  Created by James Dellinger on 10/19/17.
//  Copyright © 2017 James Dellinger. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
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
    
    // MARK: Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    // So that we can adjust the height constraints for the textfields
    // when an image is displayed -- we want the text to always appear
    //overlaying the image, not outside its boundaries
    @IBOutlet weak var bottomTextFieldHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topTextFieldHeightConstraint: NSLayoutConstraint!
    
    // So that we can adjust the width of the bottom and top text fields
    // when an image is displayed -- we don't want the text to run past the
    // left and right border of an image
    @IBOutlet weak var topTextFieldLeadingWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var topTextFieldTrailingWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomTextFieldLeadingWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomTextFieldTrailingWidthConstraint: NSLayoutConstraint!
    
    // MARK: Text Field Delegate object
    let textFieldDelegate = TextFieldDelegate()

    // MARK: meme text attributes dictionary
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "Impact", size: 40)!,
        NSStrokeWidthAttributeName: -3.0
    ]
    
    //MARK: Set properties for both text fields
    func configureTextField(textField: UITextField) {
        // Ensure text font and color are displayed according our specifications
        textField.defaultTextAttributes = memeTextAttributes
        
        // Set each text field's alignment to center
        textField.textAlignment = .center
        
        // Ensure each text field's font size shrinks to fit
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 12
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the placeholder text for each text field
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        
        // Configure alignment and formatting attributes for each text field
        configureTextField(textField: topTextField)
        configureTextField(textField: bottomTextField)
        
        // Set the two text field delegates
        self.topTextField.delegate = textFieldDelegate
        self.bottomTextField.delegate = textFieldDelegate
        
        // Share button starts off disabled. Will enable it upon selecting an image
        shareButton.isEnabled = false
    }
    
    // Check whether camera is available
    override func viewDidAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    // MARK: Picking an image
    @IBAction func pickAnImage(_ sender: Any) {
        presentImagePicker(sourceType: .photoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        presentImagePicker(sourceType: .camera)
    }
    
    // Present the proper image picker, depending on whether user chose
    // camera or photo library
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if sourceType == .photoLibrary {
            imagePicker.sourceType = .photoLibrary
        } else {
            imagePicker.sourceType = .camera
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        }
        
        // When controller is dismissed after an image has been selected,
        // share button is then enabled
        // Also change top and bottom text field height constaints so that they
        // appear overlaying the image
        dismiss(animated: true, completion: {
            // Enable share button
            self.shareButton.isEnabled = true
            // And then set custom constrains for bottom and top text field
            // vertical spacing
            self.updateTextFieldHeightConstraints()
            // And finally, set custom constraints for the widths of bottom and
            // top text field
            self.updateTextFieldWidthConstraints()
        })
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Rotation Override
    // If an image has been displayed in the image view, and the device
    // rotated, refresh the top and bottom text field constraints,
    // so that they are in proper position relative to the view of the image
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if imageView.image != nil {
            updateTextFieldHeightConstraints()
            updateTextFieldWidthConstraints()
        }
    }
    
    // MARK: Update Text Field Height Constraints
    // Set updated constraints for bottom and top text field vertical spacing
    // when an image is displayed in image viewer
    func updateTextFieldHeightConstraints() {
        let imageBoundaries: CGRect = self.imageView.displayedImageBounds()
        // Used 70 because these are default constraints of both
        // text fields from top and bottom of image view area
        self.bottomTextFieldHeightConstraint.constant
            = -imageBoundaries.midY + (imageBoundaries.height/2) - 70
        
        self.topTextFieldHeightConstraint.constant
            = -imageBoundaries.midY + (imageBoundaries.height/2) - 70
    }
    
    // MARK: Update Text Field Width Constraints
    // Call this function after an image is displayed inside the
    // image view. Ensures that displayed text won't run past the
    // left or right borders of the displayed image
    func updateTextFieldWidthConstraints() {
        // Ensure that text field width never exceeds an image's width, if
        // an image is displayed
        if let _ = imageView.image {
            let imageBoundaries: CGRect = self.imageView.displayedImageBounds()
            self.topTextFieldLeadingWidthConstraint.constant = imageBoundaries.minX
            self.topTextFieldTrailingWidthConstraint.constant = imageBoundaries.maxX
            self.bottomTextFieldLeadingWidthConstraint.constant = imageBoundaries.minX
            self.bottomTextFieldTrailingWidthConstraint.constant = imageBoundaries.maxX
        }
    }
    
    // MARK: Raise View When Keyboard Will Appear
    // Subsbscribe to keyboard notifications when view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
        // MARK: Hide top navigation bar here
        navigationController?.isNavigationBarHidden = true
        
        // Since we hide top and bottom tool bars just before transitioning to next screen,
        // must un-hide them right before this view appears again
        topToolBar.isHidden = false
        bottomToolBar.isHidden = false
    }
    
    // Unsubscribe from keyboard notifications when view will disappear
    // Also unhide navigation bar here, so that transition to next view is smoother
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        
        //MARK: Un-hide top navigation bar here before going to next (either 
        //collection or table) screen
        navigationController?.isNavigationBarHidden = false
        
        //Hiding both top and bottom tool bars right before transition to next screen
        //occurs makes the transition appear smoother
        topToolBar.isHidden = true
        bottomToolBar.isHidden = true
    }
    
    //MARK: Un-hide top navigation bar before next view loads
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    func subscribeToKeyboardNotifications() {
        //Know when the keyboard will appear
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        //Know when the keyboard will hide
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    // When the keyboardWillShow notification is received, shift the view's frame up
    func keyboardWillShow(_ notification:Notification) {
        // We only move the keyboard up if the bottom text field is being edited
        if bottomTextField.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    // Determine height of user's keyboard, so we know how much to raise, and then
    // lower the view
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    // When keyboardWillHide notification is received, then
    // shift the view's frame back down
    func keyboardWillHide(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    // MARK: Saving the meme
    
    // Generate an image of the complete meme, making sure to hide
    // both toolbars before capturing
    func generateMemedImage() -> UIImage {
        
        // Render view to an image:
        // Use our displayedImageBounds method inside our UIImageView extension to
        // return the frame rectangle that describes the image's location and size.
        // The X,Y coordinates of these image boundaries are determined relative to
        // the bounds of our imageView image view area
        let imageBoundaries: CGRect = self.imageView.displayedImageBounds()
        
    
        // However, because the methods below calculate view area based on the bounds of the
        // entire device screen, we need to account for the height of the top tool bar
        // and here we grab the height of the top tool bar in order to be sure that our
        // generated image's starting Y coordinate is the point on the screen where the
        // actual image starts being displayed.
        // Note that this approach means we don't have to worry about hiding and unhiding
        // the top and bottom tool bars. They simply won't be included in the generated
        // meme image.
        let topToolBarHeight = topToolBar.bounds.maxY
        
        // We call the below methods with our imageBoundaries CGRect and topToolBarHeight CGFloat
        // generate and return grab a bitmap screenshot of just the bounds of the image. We need
        UIGraphicsBeginImageContextWithOptions(CGSize(width: imageBoundaries.width, height: imageBoundaries.height), false, 0.0)
        self.view.drawHierarchy(in: CGRect(x: -imageBoundaries.minX, y: -imageBoundaries.minY - topToolBarHeight, width: view.bounds.size.width, height: view.bounds.size.height), afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return memedImage
    }
    
    // Method that uses our Meme struct defined in Meme.swift to generate an actual meme object
    // that can be saved or shared
    func saveMeme() {
        // Update the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: generateMemedImage())
        
        // And it to the shared data model memes array on the Application Delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    // MARK: Share the meme image
    @IBAction func shareImage(_ sender: Any) {
        let image = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        // Present the activity controller
        //self.present(activityController, animated: true, completion: {self.saveMeme()})
        self.present(activityController, animated: true, completion: nil)

        // If user completes an activity inside activity controller, such as sharing,
        // then go ahead and save the meme
        activityController.completionWithItemsHandler = {(activityType: UIActivityType?, completed:Bool, returnedItems:[Any]?, error: Error?) in
            if completed {
                self.saveMeme()
            }
        }
    }
}

// MARK: UIImageView extenstion
// This helps us know the boundaries of an image, once it's been selected
// so that we can automatically reposition the top and bottom text fields
// to display over the image, once it's been selected
extension UIImageView {
    
    func displayedImageBounds() -> CGRect {
        let boundsWidth = bounds.size.width
        let boundsHeight = bounds.size.height
        let imageSize = image!.size
        let imageRatio = imageSize.width / imageSize.height
        let viewRatio = boundsWidth / boundsHeight
        if viewRatio > imageRatio {
            let scale = boundsHeight / imageSize.height
            let width = scale * imageSize.width
            let topLeftX = (boundsWidth - width) * 0.5
            return CGRect(x: topLeftX, y: 0, width: width, height: boundsHeight)
        }
        let scale = boundsWidth / imageSize.width
        let height = scale * imageSize.height
        let topLeftY = (boundsHeight - height) * 0.5
        return CGRect(x: 0, y: topLeftY, width: boundsWidth, height: height)
    }
}

