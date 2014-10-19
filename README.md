# STNotificationHelper

[![Version](https://img.shields.io/cocoapods/v/STNotificationHelper.svg?style=flat)](http://cocoadocs.org/docsets/STNotificationHelper)
[![License](https://img.shields.io/cocoapods/l/STNotificationHelper.svg?style=flat)](http://cocoadocs.org/docsets/STNotificationHelper)
[![Platform](https://img.shields.io/cocoapods/p/STNotificationHelper.svg?style=flat)](http://cocoadocs.org/docsets/STNotificationHelper)

## Podfile

```ruby
platform :ios, '6.0'
pod 'STNotificationHelper'
```

##Usage

```objective-c
NSString *title = @"Benachrichtungen aktivieren";
NSString *descriptionString = @"Um die Notificationen verwenden zu können müssen sie die Banachrichtungen aktivieren.";

MHNotificationHelperObject *notificationObject = [MHNotificationHelperObject objectWithTitle:title
description:descriptionString
appIcon:nil
appName:@"meine App"];

MHNotificationHelperViewController *notificationHelper = [MHNotificationHelperViewController.alloc initWithNotification:notificationObject];
notificationHelper.bannerLabel.text = NSLocalizedString(@"Banner", nil);

[self presentViewController:notificationHelper animated:YES completion:nil];


```
## Authors

Mario Hahn, https://github.com/mariohahn
Nestor, https://github.com/nmaletm

## License

STNotificationHelper is available under the MIT license. See the LICENSE file for more info.
