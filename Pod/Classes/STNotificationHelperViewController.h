//
//  STNotificationHelperViewController.h
//
//

#import <UIKit/UIKit.h>

extern NSBundle *STNotificationBundle(void);
extern void STNotificationCustomLocalizationBlock(NSString *(^customLocalizationBlock)(NSString *stringToLocalize));
extern NSString *STNotificationLocalizedString(NSString *localizeString);

@interface STNotificationHelperObject : NSObject

/**
 @var Title of the view
 */
@property (nonatomic,strong) NSString *title;

/**
 @var Description of the reason the app is better with push (subtitle)
 */
@property (nonatomic,strong) NSString *notifciationDescription;

/**
 @var Icon of the app
 */
@property (nonatomic,strong) UIImage  *appIcon;

/**
 @var Name of the app
 */
@property (nonatomic,strong) NSString *appName;

/**
 Get a configured object to open the view controller
 
 @param title Title of the view
 @param notificationDescription Description of the reason the app is better with push (subtitle)
 @param appIcon Icon of the app
 @param appname Name of the app
 @return The reference to the STNotificationHelperObject object
 */
+ (instancetype)objectWithTitle:(NSString*)title
                    description:(NSString*)notificationDescription
                        appIcon:(UIImage*)appIcon
                        appName:(NSString*)appname;

/**
 Get a configured object to open the view controller using the default app icon and app name
 
 @param title Title of the view
 @param notificationDescription Description of the reason the app is better with push (subtitle)
 @return The reference to the STNotificationHelperObject object
 */
+ (instancetype)objectWithTitle:(NSString*)title
                    description:(NSString*)notificationDescription;

@end

@interface STUISwitchView : UIView
@end



@interface STNotificationHelperViewController : UIViewController

/**
 Show a view with the steps that the user has to follow to enable the push notifications again.

 @param notification information about the app
 @return The reference to the STNotificationHelperViewController
 */
- (id)initWithNotification:(STNotificationHelperObject*)notification;
@end
