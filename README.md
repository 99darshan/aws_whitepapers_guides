[![Google Play Store Download](https://play.google.com/intl/en_us/badges/images/generic/en_badge_web_generic.png)](https://play.google.com/store/apps/details?id=np.com.a99darshan.aws_whitepapers_guides&hl=en)

# AWS Whitepapers & Guides

Android App developed with Flutter to browse, save, view and download Amazon Web Services (AWS) Whitepapers, Technical Guides, Reference Material and Architectural Diagram

This is a reference mobile app for [AWS documentation webpage](https://aws.amazon.com/whitepapers/?whitepapers-main.sort-by=item.additionalFields.sortDate&whitepapers-main.sort-order=desc)

# What could be better
I believe in learning by doing, so I jumped right in and started building this app. Here are few stupid stuff I've done. 

* It makes use of provider package for state management, but the implementation doesn't quite follow the best practices and has room for refactor and improvement. 

* Stores the bookmarks json in shared preferences :man_facepalming: Even though I didn't want to have user signup and server to store the user specific bookmarks, I could've saved them in local persistant storage using SQLite package sqflite or no sql equivalent packages like sembast or hive.

* Should've planned a bit more on color scheme and theme beforehand. I so want to add a dark theme. Yet to wrap my head around Theming in Flutter.

* Pulls data from the AWS API. Doesn't support offline mode. App of this nature would've benefited much from having a offline support. However, downloaded files can be accessed offline from within the app :smiley:

# Screenshots :framed_picture:



