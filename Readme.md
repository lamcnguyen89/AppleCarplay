# Apple Carplay Example

[![License: Unlicense](https://img.shields.io/badge/license-Unlicense-blue.svg)](http://unlicense.org/)

This application is an example of how to implement Carplay Functionality to a pre-existing iOS application. In order to add Carplay Functionality to an application, you will be working in the Scene Delegate and App Delegate portion of your code.


## Adding the Carplay Architecture to Your Preexisting App

Adding Carplay Functionality involves two overall processes:

- Adding Entitlements to your Code and Requesting the Carplay Entitlement from Apple in order to test your application in a vehicle.

-  Working with the Scene And App Delegate to implement Carplay Capabilities

The specifics of these two steps will be discussed below.


## Adding Entitlements to your Preexisting App

You first have to add an entitlement file to allow for the application to have permission to use Carplay capabilities.

1. Within this application, the entitlements file is named AppleCarplayTesting.entitlements and is located in the folder AppleCarplay/"Supporting Files". You can use this file as a template for your own application.

2. To add your own Entitlements file, right-click and select "New File". Select a "Property List" File under the "Resources" header.

3. Rename this Property List File to anything you want, but give the file format of ".entitlements". For example, when you create this property list file, rename it "Carplay.Entitlements"

4. Within the Entitlements file, you will want to add a specific carplay capability in the format of the screenshot below:

![EntitlementsExample](ReadmeScreenshots/Entitlements_Entry.png)

5. Depending on what carplay capabilities you want to use, add a specific capability based on the screenshot below of the list of capabilities:

![EntitlementsExample](ReadmeScreenshots/Carplay_Entitlements_List.png)



## Working with Scene

The Scene and App Delegate basically specifies what the application will do when events such as application start, application disconnect, phone calls occur, and/or connecting an iPhone to a Carplay compatible vehicle occurs... Basically actions involving the iphone external to that of the UI of the App.


## Credit Goes To:

- [here](https://www.udemy.com/course/build-ecommerce-website-like-amazon-react-node-mongodb/)
- 
## Prerequisites and Deployment

- Installation of Web Browser to view webpage
- Visual Studio Code to analze the code for the website
- Node.js
- React JS
- Installation of Node Package Modules

## Built With

- Xcode
- SwiftUI


## Author

**Lam Nguyen**

## License

The Unlicense


