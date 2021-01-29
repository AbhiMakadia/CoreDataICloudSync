
# I-Cloud Sync with Coredata

[![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat)](https://swift.org)

This repository is an example project of how to integrate coredata database and sync to the I-Cloud.

### Preview
![alt text](https://github.com/AbhiMakadia/CoreDataICloudSync/blob/main/Previews/preview.gif)

### Certificate Setup
1. Select the `Signing & Capabilities` tab in the target editor
2. Click on `+ Capability`
3. Choose `iCloud`

##### Select the Signing & Capabilities tab in the target editor
Open ICloudSync.xcworkspace in Xcode. Select the ICloudSync project in the Project navigator, then select the ICloudSync target. With the General tab selected, replace the Bundle Identifier with something unique. Standard practice is to use reverse domain name notation and include the project name.
<p align="center">
    <img src="Previews/1.png">
</p>

##### Click on + Capability
![alt text](https://github.com/AbhiMakadia/CoreDataICloudSync/blob/main/Previews/2.png)
At this point, Xcode might prompt you to enter the Apple ID associated with your iOS developer account. If so, then type it in as requested.

##### Choose iCloud
Next, enable CloudKit by checking the CloudKit checkbox in the Services group.
![alt text](https://github.com/AbhiMakadia/CoreDataICloudSync/blob/main/Previews/3.png)
Finally, click on + under Containers to add a new container, if CloudKit didn’t automatically create one for you.
![alt text](https://github.com/AbhiMakadia/CoreDataICloudSync/blob/main/Previews/4.png)
In the pop-up, add your bundle identifier.
![alt text](https://github.com/AbhiMakadia/CoreDataICloudSync/blob/main/Previews/5.png)
This creates a default container named iCloud.<your app’s bundle ID>.
![alt text](https://github.com/AbhiMakadia/CoreDataICloudSync/blob/main/Previews/6.png)
For CloudKit Dashboard, you can do this using the CloudKit dashboard. Click CloudKit Dashboard, which you can find in the target’s Signing & Capabilities pane, under iCloud or by opening https://icloud.developer.apple.com/dashboard/ in your browser.
