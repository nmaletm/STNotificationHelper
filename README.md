# STNotificationHelper

[![Version](https://img.shields.io/cocoapods/v/STNotificationHelper.svg?style=flat)](http://cocoadocs.org/docsets/STNotificationHelper)
[![License](https://img.shields.io/cocoapods/l/STNotificationHelper.svg?style=flat)](http://cocoadocs.org/docsets/STNotificationHelper)
[![Platform](https://img.shields.io/cocoapods/p/STNotificationHelper.svg?style=flat)](http://cocoadocs.org/docsets/STNotificationHelper)

Forked project from [MHNotificationHelper](https://github.com/mariohahn/MHNotificationHelper), with support for iOS8 (the instructions are different) and translation to some languages.

![alt tag](Screenshots/screenshote-ios7.png)

## Language support

en, es, de, fr, id, it, pl, pt, ru, sv.

## Podfile

```ruby
platform :ios, '6.0'
pod 'STNotificationHelper'
```

##Usage

```objective-c
NSString *title = @"Take advantage of MySuperApp";
NSString *descriptionString = @"MySuperApp is better with Push Notifications. We will spam you a lot! :)";

STNotificationHelperObject *notificationObject = [STNotificationHelperObject objectWithTitle:title
description:descriptionString
appIcon:nil
appName:@"MySuperApp"];

STNotificationHelperViewController *notificationHelper = [STNotificationHelperViewController.alloc initWithNotification:notificationObject];
notificationHelper.bannerLabel.text = NSLocalizedString(@"Banner", nil);

[self presentViewController:notificationHelper animated:YES completion:nil];


```
## Authors

* Mario Hahn, https://github.com/mariohahn (author of the original forked Pod)
* Nestor, https://github.com/nmaletm

## License

STNotificationHelper is available under the MIT license. See the LICENSE file for more info.

## Donating

Support this project via gittip.

<a href="https://gratipay.com/nmaletm/" target="_blank">
  <img alt="Support via Gratipay" src="https://rawgithub.com/twolfson/gittip-badge/0.2.0/dist/gittip.png"/>
</a>
