# AWS Whitepapers & Guides

Android App developed with Flutter to browse, save, view and download Amazon Web Services (AWS) Whitepapers, Technical Guides, Reference Material and Architectural Diagram

This is a reference mobile app for [AWS documentation webpage](https://aws.amazon.com/whitepapers/?whitepapers-main.sort-by=item.additionalFields.sortDate&whitepapers-main.sort-order=desc)

[![Google Play Store Download](https://play.google.com/intl/en_us/badges/images/generic/en_badge_web_generic.png)](https://play.google.com/store/apps/details?id=np.com.a99darshan.aws_whitepapers_guides&hl=en)

# What could have been done better

* Stores the bookmarks json in shared preferences :man_facepalming: Even though I didn't want to have user signup and a server to store the user specific bookmarks, I could've saved them in local persistant storage using SQLite package sqflite or no sql equivalent packages like sembast or hive.

* Pulls data from the AWS API. Doesn't support offline mode. However, downloaded files can be accessed offline from within the app :smiley:

* This apps makes use of unofficiable API endpoints from AWS. If AWS were to make changes to their API, this app will probably break.


# Screenshots :framed_picture:
<a href="url"><img src="https://user-images.githubusercontent.com/9456191/87846625-eb15c480-c8f0-11ea-879a-3c984fc750a4.png" width="250" ></a>


<a href="url"><img src="https://user-images.githubusercontent.com/9456191/87846621-e6511080-c8f0-11ea-925a-7947e3096874.png" width="250" ></a>


<a href="url"><img src="https://user-images.githubusercontent.com/9456191/87846622-e9e49780-c8f0-11ea-809b-9ec13df3625d.png" width="250" ></a>


<a href="url"><img src="https://user-images.githubusercontent.com/9456191/87846623-ea7d2e00-c8f0-11ea-8ae4-4429bcc414bd.png" width="250" ></a>


<a href="url"><img src="https://user-images.githubusercontent.com/9456191/87846624-eb15c480-c8f0-11ea-92f2-96a77f427850.png" width="250" ></a>


<a href="url"><img src="https://user-images.githubusercontent.com/9456191/87846626-ebae5b00-c8f0-11ea-8c21-0e6b473355a4.png" width="250" ></a>




