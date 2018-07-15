# iOS Developer Nanodegree: MemeMe Version 2.0 App
*Mastering the major UI components found in essentially every app, and combining them with the camera and social media activity views.*

<img src="https://github.com/jamesdellinger/ios-nanodegree-meme-me-version-2-app/blob/master/iosndlogo.jpg" alt="iOS Developer Nanodegree logo" height="100" >

## Overview
This repository contains the MemeMe Version 2.0 app project for the **UIKit Fundamentals** course in Udacity's [iOS Nanodegree](https://www.udacity.com/course/ios-developer-nanodegree--nd003).

MemeMe Version 2.0 enables a user to take a picture, and add text at the top and bottom to form a meme. They can then share this meme on Facebook and Twitter, and also by SMS or email. In this app, sent memes will appear in a tab view with two tabs: a table view and a collection view.

## My Implementation's User-friendly Tweaks
1. First screen user sees upon app opening is meme editor screen. Like camera in Snapchat, users would open this app to
    create and send out a funny meme that just popped into their mind. Boom. Also, imagine how bad it would be opening up
    to an empty collection view on first-time-ever app launch.

    No one is gonna open this app to enjoy its
    table and collection view meme browsing experience. (Though, it is possible to browse through the library of old memes
    from long ago, should one desire.):

    <img src="https://github.com/jamesdellinger/ios-nanodegree-meme-me-version-2-app/blob/master/Screenshots/Screen%20Shot%202017-10-22%20at%209.35.29%20PM.png" height="400">

2. Collection and table views uniformly display the most ideal crops of meme images. No matter if the meme image's orientation
    is landscape or portrait, thumbnail crop includes all, or at least the bulk of, the top and bottom white meme text:

    <img src="https://github.com/jamesdellinger/ios-nanodegree-meme-me-version-2-app/blob/master/Screenshots/Screen%20Shot%202017-10-22%20at%209.27.32%20PM.png" height="300">

    <img src="https://github.com/jamesdellinger/ios-nanodegree-meme-me-version-2-app/blob/master/Screenshots/Screen%20Shot%202017-10-22%20at%209.27.46%20PM.png" height="300">

3. When a picture is loaded into the meme editor, top and bottom meme text fields always automatically readjust to top of
    meme image, no matter if image is landscape or portrait. User doesn't have to rotate phone to landscape to get the text
    fields to the top and bottom of a landscape image (though app does support rotation, should user desire to do so). (But really, as of 2017, who even rotates their phones to landscape?):

    <img src="https://github.com/jamesdellinger/ios-nanodegree-meme-me-version-2-app/blob/master/Screenshots/Screen%20Shot%202017-10-22%20at%209.35.58%20PM.png" height="400">

    <img src="https://github.com/jamesdellinger/ios-nanodegree-meme-me-version-2-app/blob/master/Screenshots/Screen%20Shot%202017-10-22%20at%209.49.40%20PM.png" height="400">

4. Top and Bottom text fields auto-shrink size of text down to a minimum size. This keeps really long meme labels from
    overrunning the width of the meme image, no matter how narrow or wide it is. After the minimum text size is reached, only
    then does the label get truncated:

    <img src="https://github.com/jamesdellinger/ios-nanodegree-meme-me-version-2-app/blob/master/Screenshots/Screen%20Shot%202017-10-22%20at%2010.23.05%20PM.png" height="400">

    <img src="https://github.com/jamesdellinger/ios-nanodegree-meme-me-version-2-app/blob/master/Screenshots/Screen%20Shot%202017-10-22%20at%2010.24.31%20PM.png" height="400">

5. Finally, when saving a meme, app auto-crops out app chrome, borders, empty space, and only saves the actual meme
   image, itself:

    <img src="https://github.com/jamesdellinger/ios-nanodegree-meme-me-version-2-app/blob/master/Screenshots/Screen%20Shot%202017-10-22%20at%209.36.19%20PM.png" height="400">

## Project Grading and Evaluation
* [Project Review](https://github.com/jamesdellinger/ios-nanodegree-meme-me-version-2-app/blob/master/ios-nanodegree-meme-me-version-2-app-review.pdf)

* Project Grading Rubric](https://github.com/jamesdellinger/ios-nanodegree-meme-me-version-2-app/blob/master/meme-me-version-2-app-specs-and-rubric.pdf)
