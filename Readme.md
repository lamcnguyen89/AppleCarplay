# Apple Carplay Example

[![License: Unlicense](https://img.shields.io/badge/license-Unlicense-blue.svg)](http://unlicense.org/)

This application is an example of how to implement Carplay Functionality to a pre-existing iOS application. In order to add Carplay Functionality to an application, you will be working in the Scene Delegate and App Delegate portion of your code.


## Adding the Carplay Architecture to Your Preexisting App

Adding Carplay Functionality involves three overall processes:

- Adding Entitlements to your Code

- Requesting the Carplay Entitlement from Apple in order to test your application in a vehicle.

-  Working with the Scene And App Delegate to implement Carplay Capabilities

The specifics of these two steps will be discussed below.


## Adding Entitlements to your App

You first have to add an entitlement file to allow for the application to have permission to use Carplay capabilities.

1. Within this application, the entitlements file is named AppleCarplayTesting.entitlements and is located in the folder AppleCarplay/"Supporting Files". You can use this file as a template for your own application.

2. To add your own Entitlements file, right-click and select "New File". Select a "Property List" File under the "Resources" header.

3. Rename this Property List File to anything you want, but give the file format of ".entitlements". For example, when you create this property list file, rename it "Carplay.Entitlements"

4. Within the Entitlements file, you will want to add a specific carplay capability in the format of the screenshot below:

![EntitlementsExample](ReadmeScreenshots/Entitlements_Entry.png)

5. Depending on what carplay capabilities you want to use, add a specific capability based on the screenshot below of the list of capabilities:

![EntitlementsExample](ReadmeScreenshots/Carplay_Entitlements_List.png)

6. Open the project's Build Settings and ensure your Code Signing Entitlements points to your created Entitlements file like the screenshot below:

![EntitlementsExample](ReadmeScreenshots/Code_Signing.png)

Ensure that the file location is entered correctly based on the root of the project.


## Requesting Carplay Entitlements from Apple (Optional for Development Purposes)

So you are able to test the Carplay Functionality and Capabilities of your application in the Simulator by going into the I/O options for the simulator and choosing the Carplay Option to test. However in order to test your application on a device, on an actual vehicle and to deploy the app to the app store... You will need to go to Request Entitlements from Apple.

1. First, You need to have a Developer Account. A Developer account cost $100 USD per year....

2. Once you have a developer account, you have to contact Apple [here](https://developer.apple.com/contact/carplay/) to ask Apple to add Carplay Capabilities to your developer account. Otherwise, you won't be able to test on a device and can only test on a simulator. You will have to send a link to Apple showing them your code so they can inspect it.

3. If Apple approves your request to add Carplay Entitlement permissions to your developer account, you will have to then add Carplay capabilities to your particular application. Rather then me writing this all it for you, it will be easier to just read Apple's Docs explaining this process [here](https://developer.apple.com/documentation/carplay/requesting_carplay_entitlements).


In summary each app is signed to a certain developer account. A user's apple device or vehicle with Carplay capabilities will check the developer account that the app is signed to to see what this developer account is allowed to do. If the app passes the security and capabilities check, the App can run. By default, a developer account doesn't have Carplay capabilities possibly for security and quality control purposes. So you have to ask Apple to add Carplay Capabilities to your developer account in order for your carplay app to run in a vehicle.

  

## Working with Scene and App Delegate

The Scene and App Delegate basically specifies what the application will do when events such as application start, application disconnect, phone calls occur, and/or connecting an iPhone to a Carplay compatible vehicle occurs... Basically actions involving the iphone external to that of the UI of the App.


## Credit Goes To:

- [here](https://www.udemy.com/course/build-ecommerce-website-like-amazon-react-node-mongodb/)
- 
## Prerequisites and Deployment

- Mac computer to develop for iOS
- XCode 11.0 or later
- For testing on a device, use a device that can run the following OS versions: iOS 13.0+, iPadOS 13.0+, macOS 10.15+, Mac Catalyst 13.0+, tvOS 13.0+, watchOS 6.0+

## Built With

- Xcode
- SwiftUI


## Author

**Lam Nguyen**

## License

The Unlicense


