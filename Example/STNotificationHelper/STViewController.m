//
//  STViewController.m
//  STNotificationHelper
//
//  Created by Nestor on 10/19/2014.
//  Copyright (c) 2014 Nestor. All rights reserved.
//

#import "STViewController.h"
#import "STNotificationHelperViewController.h"

@interface STViewController ()

@end

@implementation STViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSString *title = @"Take advantage of MySuperApp";
    NSString *descriptionString = @"MySuperApp is better with Push Notifications. We will spam you a lot! :)";
    
    STNotificationHelperObject *notificationObject = [STNotificationHelperObject objectWithTitle:title
                                                                                     description:descriptionString
                                                                                         appIcon:nil
                                                                                         appName:@"MySuperApp"];
    
    STNotificationHelperViewController *notificationHelper = [STNotificationHelperViewController.alloc initWithNotification:notificationObject];
    notificationHelper.bannerLabel.text = NSLocalizedString(@"Banner", nil);
    
    [self presentViewController:notificationHelper animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
