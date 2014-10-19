//
//  STNotificationHelperViewController.h
//
//

#import <UIKit/UIKit.h>

extern NSBundle *STNotificationBundle(void);
extern void STNotificationCustomLocalizationBlock(NSString *(^customLocalizationBlock)(NSString *stringToLocalize));
extern NSString *STNotificationLocalizedString(NSString *localizeString);

@interface STNotificationHelperObject : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *notifciationDescription;
@property (nonatomic,strong) UIImage  *appIcon;
@property (nonatomic,strong) NSString *appName;


- (instancetype)initWithTitle:(NSString*)title
                  description:(NSString*)notificationDescription
                      appIcon:(UIImage*)appIcon
                      appName:(NSString*)appname;


+ (instancetype)objectWithTitle:(NSString*)title
                    description:(NSString*)notificationDescription
                        appIcon:(UIImage*)appIcon
                        appName:(NSString*)appname;
@end

@interface STUISwitchView : UIView
@end



@interface STNotificationHelperViewController : UIViewController
@property (nonatomic,strong) UIView         *contentView;

@property (nonatomic,strong) UILabel        *titleLabel;
@property (nonatomic,strong) UILabel        *descriptionLabel;

@property (nonatomic,strong) UIButton       *exitButton;
@property (nonatomic,strong) UILabel        *doesItWorkLabel;

/**
 Show a view with the steps that the user has to follow to enable the push notifications again.

 @param notification information about the app
 @return The reference to the STNotificationHelperViewController
 */
- (id)initWithNotification:(STNotificationHelperObject*)notification;
@end
