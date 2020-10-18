![Mockup](https://github.com/KuhlTime/iOSSC/blob/main/assets/mockup.png?raw=true)

# iOSSC
 [![twitter](https://img.shields.io/badge/Twitter-%40KuhlTime-1DA1F2)](https://twitter.com/@KuhlTime)

[![swift-version](https://img.shields.io/badge/swift-5.3-orange.svg)](https://github.com/apple/swift)
[![platforms](https://img.shields.io/badge/platform-iOS-lightgrey)]()


A iOS client application for retrieving your Grades from the OSSC servers.

This application works in conjunction with my node-ossc web server which recives and processes the grades page provided by the OSSC.
The Server then returns a developer friendly JSON object back to the client application. 

The endpoint for the API is located at [https://api.kuhlti.me/ossc/modules](https://api.kuhlti.me/ossc/modules).

### Web App

Besides the iOS Client there is also a web based application available. Check out: [https://hsd.kuhlti.me](https://hsd.kuhlti.me)

## Installation
These steps while help you to install a local version of this app on your device.

1. Download Xcode from the Mac App Store.
2. Once installed you should be able to open the `iOSSC.xcodeproj` file. Alternativly you can press the green download button at the root of this repository and press the Button `Open with Xcode`.
3. Once open you should be presented with the application's code. Go ahead and select the upper most item from the list on the left `iOSSC`.
4. Under `Targets > iOSSC` select `Signing & Capabilites` you there have to "sign" your application with your personal apple id.
5. Once the application has been signed you can choose either a Simulator or a real physical device from the dropdown menu next to the status bar on the top.
6. Hit the play button and the application should start running.

![Xcode Setup](https://github.com/KuhlTime/iOSSC/blob/main/assets/xcode-setup.png?raw=true)