# Quopho iOS App - Swift
An app that you can create affirming scenes with calming quotes and pictures

### About
Initial page welcomes the user and allows them to view their already made QuotePhoto (called quophos in the app) or go to create a new one
![ ](welcomeScreen.png)

If the user decides to create a new quopho, they get to this screen that gets random quote data from Forismatic API (http://forismatic.com/en/api/) in English. The user can decide whether to use the quote or query the API database for another quote
![ ](findAQuoteScreen.png)

Once the user picks a quote, they go to the next screen which is a UICollectionView of image data from Flickr API (https://www.flickr.com/services/api/). The user can use the search toolbar to search for a photo they like and will want to click on one to save. It is saved to CoreData
Both APIs- Forismatic and Flickr are free to use
![ ](findAPhotoScreen.png)

![ ](viewPhotoScreen.png)

One entity named "QuotePhoto" is used for Core Data's persistent storage. It holds the data of both the quote and the photo. 

Once the "QuotePhoto" aka "quopho" is saved you go to a UICollectionView of all the saved quophos. This is the same viewcontroller you go to from the Welcome Screen if you just want to see your already made creations
![ ](collectionOfQuotePhotosScreen.png)

The user can just take a look at their quopho they want bigger on the phone and hopefully enjoy!
![ ](viewQuophoLarge.png)

### References
Taught by Clara James and used some repos to help with project
- https://github.com/claraj/snore_data_ios
- https://github.com/claraj/quotes_api_ios
- https://github.com/claraj/national_park_explorer_ios
- https://github.com/claraj/floor_data_ios

Also
- https://github.com/SheldonWangRJT/iOS-Swift4-SearchBar-TableView-iPhoneX

### Available For Download
download Xcode, this app was made for Swift 4
clone the repository for this project and then open and run with Xcode
Please request a Flickr API key from Flickr here- https://www.flickr.com/services/apps/ as a courtesy 
it's free and then you can reuse the API for another app too.


