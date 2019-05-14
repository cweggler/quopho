# Quopho iOS App - Swift
An app that you can create affirming scenes with calming quotes and pictures

### About
Gets quote data from Forismatic API (http://forismatic.com/en/api/)
Gets image data from Flickr API (https://www.flickr.com/services/api/) 
Both APIs free to use

Allows the user to keep querying the database until a quote is found and then a photo is found.
Once a photo is selected and saved, both the quote and photo are saved to CoreData.

One entity named "QuotePhoto" is used for Core Data's persistent storage. It holds the data of both the quote and the photo.

Uses two UICollectionViews, one to show the images the user can select to save, the other to show the total quophos a user created

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


