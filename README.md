<img src="https://s3-us-west-1.amazonaws.com/udacity-content/degrees/catalog-images/nd003.png" alt="iOS Developer Nanodegree logo" height="70" >

# MemeMe Version 2.0 App

![Platform iOS](https://img.shields.io/badge/nanodegree-iOS-blue.svg)

This repository contains the MemeMe Version 2.0 app project for the UIKit Fundamentals course in Udacity's iOS Nanodegree.

With some user-friendly tweaks:

1. First screen user sees upon app opening is meme editor screen. Like camera in Snapchat, users would open this app to
    create and send out a meme, not to browse a library of old memes from long ago. Also, imagine how bad it would be
    opening up to an empty collection view on first time ever app launch:

    /Users/jamesdellinger/Dropbox/Files/Udacity Classes/iOS Developer Nanodegree/ios-nanodegree-meme-me-version-2-app/Screenshots/Screen Shot 2017-10-22 at 9.35.29 PM.png

2. Collection and table views uniformly display the most ideal crops of meme images. No matter if the meme image's orientation
    is landscape or portrait, thumbnail crop includes all, or at least the bulk of, the top and bottom white meme text:

    /Users/jamesdellinger/Dropbox/Files/Udacity Classes/iOS Developer Nanodegree/ios-nanodegree-meme-me-version-2-app/Screenshots/Screen Shot 2017-10-22 at 9.27.32 PM.png

    /Users/jamesdellinger/Dropbox/Files/Udacity Classes/iOS Developer Nanodegree/ios-nanodegree-meme-me-version-2-app/Screenshots/Screen Shot 2017-10-22 at 9.27.46 PM.png

3. When a picture is loaded into the meme editor, top and bottom meme text fields always automatically readjust to top of
    meme image, no matter if image is landscape or portrait. User doesn't have to rotate phone to landscape to get the text
    fields to the top and bottom of a landscape image. (Cause really, as of 2017, who even rotates their phones to landscape?):
    
    /Users/jamesdellinger/Dropbox/Files/Udacity Classes/iOS Developer Nanodegree/ios-nanodegree-meme-me-version-2-app/Screenshots/Screen Shot 2017-10-22 at 9.35.58 PM.png

    /Users/jamesdellinger/Dropbox/Files/Udacity Classes/iOS Developer Nanodegree/ios-nanodegree-meme-me-version-2-app/Screenshots/Screen Shot 2017-10-22 at 9.49.40 PM.png
    
    4. Finally, when saving a meme, app auto-crops out app chrome, borders, empty space, and only saves the actual meme
    image, itself:
    
    /Users/jamesdellinger/Dropbox/Files/Udacity Classes/iOS Developer Nanodegree/ios-nanodegree-meme-me-version-2-app/Screenshots/Screen Shot 2017-10-22 at 9.36.19 PM.png
