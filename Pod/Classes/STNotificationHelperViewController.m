//
//  STNotificationHelperViewController.m
//
//

#import "STNotificationHelperViewController.h"
#import "Masonry.h"

#define kSTNotificationBundleName @"STNotification.bundle"

#define kPaddingBetweenLabels 28
#define kPaddingBetweenViews 10
#define kPaddingImageView 5

static NSString* (^ CustomLocalizationBlock)(NSString *localization) = nil;

NSBundle *STNotificationBundle(void) {
    static NSBundle *bundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString* path = [NSBundle.mainBundle.resourcePath stringByAppendingPathComponent:kSTNotificationBundleName];
        bundle = [NSBundle bundleWithPath:path];
    });
    return bundle;
}

void STNotificationCustomLocalizationBlock(NSString *(^customLocalizationBlock)(NSString *stringToLocalize)){
    CustomLocalizationBlock = customLocalizationBlock;
}
NSString *STNotificationLocalizedString(NSString *localizeString)
{
    if (CustomLocalizationBlock) {
        NSString *string = CustomLocalizationBlock(localizeString);
        if (string) {
            return string;
        }
    }
    return  NSLocalizedStringFromTableInBundle(localizeString, @"STNotification", STNotificationBundle(), @"");
}

@implementation STNotificationHelperObject

- (instancetype)initWithTitle:(NSString*)title
                  description:(NSString*)notificationDescription
                      appIcon:(UIImage*)appIcon
                      appName:(NSString*)appname
{
    self = [super init];
    if (!self)
        return nil;
    self.title = title;
    self.notifciationDescription = notificationDescription;
    self.appIcon = appIcon;
    self.appName = appname;
    return self;
}

+ (instancetype)objectWithTitle:(NSString*)title
                    description:(NSString*)notificationDescription
                        appIcon:(UIImage*)appIcon
                        appName:(NSString*)appname
{
    return [self.class.alloc initWithTitle:title description:notificationDescription appIcon:appIcon appName:appname];
}

+ (instancetype)objectWithTitle:(NSString*)title
                    description:(NSString*)notificationDescription
{
    UIImage *appIcon = [UIImage imageNamed: [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIconFiles"] objectAtIndex:0]];
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];

    return [self.class.alloc initWithTitle:title description:notificationDescription appIcon:appIcon appName:appName];
}


@end

@interface STUISwitchView ()
@property (nonatomic,strong) UIView *switchView;
@end

@implementation STUISwitchView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 10.5;
        self.clipsToBounds = YES;
        self.backgroundColor = UIColor.whiteColor;
        
        _switchView = UIView.new;
        self.switchView.backgroundColor = UIColor.blackColor;
        self.switchView.layer.cornerRadius = 9;
        self.switchView.clipsToBounds = YES;
        
        [self addSubview:self.switchView];
        
        [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).with.offset(-1.5);
            make.centerY.mas_equalTo(self.center);
            make.size.mas_equalTo(CGSizeMake(18, 18));
        }];
        
    }
    return self;
}


@end

@interface STNotificationHelperViewController (){
    UIView *contentView;
}

@end

@implementation STNotificationHelperViewController

- (id)initWithNotification:(STNotificationHelperObject*)notification
{
    self = [super init];
    if (self) {
        
        self.view.backgroundColor = UIColor.blackColor;
        
        UIScrollView *scrollView = UIScrollView.new;
        scrollView = scrollView;
        scrollView.alwaysBounceHorizontal = NO;
        scrollView.backgroundColor = UIColor.blackColor;
        [self.view addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
        
        contentView = UIView.new;
        [scrollView addSubview:contentView];
        
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(scrollView);
            make.width.mas_equalTo(scrollView);
        }];
        
        UIButton *exitButton = UIButton.new;
        [exitButton addTarget:self action:@selector(exitButtonAction) forControlEvents:UIControlEventTouchUpInside];
        exitButton.tintColor = UIColor.lightGrayColor;
        exitButton.layer.cornerRadius = 35;
        exitButton.backgroundColor = UIColor.blackColor;
        [exitButton setImage:[[UIImage imageNamed:@"STExit"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [self.view addSubview:exitButton];
        
        [exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.view.mas_right).with.offset(-5);
            make.top.mas_equalTo(self.view.mas_top).with.offset(15);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        UILabel *titleLabel = UILabel.new;
        titleLabel.numberOfLines = 2;
        titleLabel.text = notification.title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = UIColor.whiteColor;
        titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [contentView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(contentView.mas_left).with.offset(20);
            make.right.mas_equalTo(contentView.mas_right).with.offset(-20);
            make.top.mas_equalTo(contentView.mas_top).with.offset(60);
        }];
        
        UILabel *descriptionLabel = UILabel.new;
        descriptionLabel.text = notification.notifciationDescription;
        descriptionLabel.numberOfLines = MAXFLOAT;
        descriptionLabel.textColor = UIColor.lightGrayColor;
        descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
        descriptionLabel.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:descriptionLabel];
        
        [descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(contentView.mas_left).with.offset(10);
            make.right.mas_equalTo(contentView.mas_right).with.offset(-10);
            make.top.mas_equalTo(titleLabel.mas_bottom).with.offset(kPaddingBetweenLabels-8);
        }];
        
        UILabel *doesItWorkLabel = UILabel.new;
        doesItWorkLabel.textColor = UIColor.whiteColor;
        doesItWorkLabel.text = STNotificationLocalizedString(@"notification.work");
        [doesItWorkLabel setAdjustsFontSizeToFitWidth:YES];
        doesItWorkLabel.font = [UIFont boldSystemFontOfSize:15];
        [contentView addSubview:doesItWorkLabel];
        
        [doesItWorkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(contentView.mas_left).with.offset(10);
            make.right.mas_equalTo(contentView.mas_right).with.offset(-10);
            make.top.mas_equalTo(descriptionLabel.mas_bottom).with.offset(kPaddingBetweenLabels-8);
        }];
        
        
        UIView *currentStep = doesItWorkLabel;
        NSInteger currentPositionStep = 1;
        
        if ([self isiOS7OrLower]) {
            currentStep = [self addOpenSettingsAtPosition:currentPositionStep++ insertUnder:currentStep];
            currentStep = [self addTapNotificationCenterAtPosition:currentPositionStep++ insertUnder:currentStep];
            currentStep = [self addSelectYourAppAtPosition:currentPositionStep++ withNotification:notification insertUnder:currentStep];

        } else {
            currentStep = [self addGoToSettingsAtPosition:currentPositionStep++ insertUnder:currentStep];
            currentStep = [self addTapNotificationCenterAtPosition:currentPositionStep++ insertUnder:currentStep];
            currentStep = [self addTurnOnAllowNotifications:currentPositionStep++ insertUnder:currentStep];

        }

        currentStep = [self addTurnOnLockScreen:currentPositionStep++ insertUnder:currentStep];
        currentStep = [self addSelectionTypeAtPosition:currentPositionStep++ insertUnder:currentStep];
   
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(currentStep.mas_bottom).with.offset(kPaddingBetweenViews);
        }];
    }
    return self;
}

#pragma mark - Tap Steps

-(UIView *)addTapStep:(NSString *)step withIcon:(NSString*)icon atPosition:(NSInteger)position insertUnder:(UIView *)currentStep
{
    UIImage *image = [UIImage imageNamed:icon];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    return [self addTapStep:step withImage:image atPosition:position insertUnder:currentStep];
}

-(UIView *)addOpenSettingsAtPosition:(NSInteger)position insertUnder:(UIView *)currentStep
{
    
    
    return [self addTapStep:STNotificationLocalizedString(@"notification.open")
                   withIcon:@"STSettings"
                 atPosition:position
                insertUnder:currentStep];
}

- (UIView *)addTapNotificationCenterAtPosition:(NSInteger)position insertUnder:(UIView *)currentStep
{
    
    return [self addTapStep:STNotificationLocalizedString(@"notification.notificationTap")
                   withIcon:@"STNotification"
                 atPosition:position
                insertUnder:currentStep];
}

- (UIView *)addGoToSettingsAtPosition:(NSInteger)position insertUnder:(UIView *)currentStep
{
    
    UILabel *numberLabel = UILabel.new;
    numberLabel.text = [NSString stringWithFormat:@"%ld.", (long)position];
    [contentView addSubview:numberLabel];
    
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView.mas_left).with.offset(10);
        make.right.mas_equalTo(contentView.mas_right).with.offset(-10);
        make.top.mas_equalTo(currentStep.mas_bottom).with.offset(kPaddingBetweenLabels);
    }];
    [self numberAppearanceForLables:@[numberLabel]];
    
    UIView *descriptionView = UIView.new;
    descriptionView.layer.cornerRadius = 8;
    descriptionView.layer.backgroundColor = UIColor.whiteColor.CGColor;
    [contentView addSubview:descriptionView];
    
    [descriptionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView.mas_left).with.offset(35);
        make.right.mas_equalTo(contentView.mas_right).with.offset(-35);
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(currentStep.mas_bottom).with.offset(kPaddingBetweenLabels-kPaddingImageView);
    }];
    
    UIButton *goToSettingsButton = UIButton.new;
    [goToSettingsButton setTitle:STNotificationLocalizedString(@"notification.open") forState:UIControlStateNormal];
    [goToSettingsButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [goToSettingsButton addTarget:self action:@selector(goToSettings) forControlEvents:UIControlEventTouchUpInside];
    [goToSettingsButton.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [descriptionView addSubview:goToSettingsButton];
    
    [goToSettingsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(descriptionView.mas_left).with.offset(0);
        make.right.mas_equalTo(descriptionView.mas_right).with.offset(0);
        make.top.mas_equalTo(descriptionView.mas_top).with.offset(0);
        make.bottom.mas_equalTo(descriptionView.mas_bottom).with.offset(0);
    }];
    
    return goToSettingsButton;
}

- (UIView *)addSelectYourAppAtPosition:(NSInteger)position withNotification:(STNotificationHelperObject*)notification insertUnder:(UIView *)currentStep
{
    
    return [self addTapStep:[NSString stringWithFormat: STNotificationLocalizedString(@"notification.app"), notification.appName]
                  withImage:notification.appIcon
                 atPosition:position
                insertUnder:currentStep];
}

-(UIView *)addTapStep:(NSString *)step withImage:(UIImage *)image atPosition:(NSInteger)position insertUnder:(UIView *)currentStep
{
    UILabel *numberLabel = UILabel.new;
    numberLabel.text = [NSString stringWithFormat:@"%ld.", (long)position];
    [contentView addSubview:numberLabel];
    
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView.mas_left).with.offset(10);
        make.right.mas_equalTo(contentView.mas_right).with.offset(-10);
        make.top.mas_equalTo(currentStep.mas_bottom).with.offset(kPaddingBetweenLabels);
    }];
    [self numberAppearanceForLables:@[numberLabel]];

    UIImageView *numberImageView = UIImageView.new;
    numberImageView.image = image;
    [contentView addSubview:numberImageView];
    
    [numberImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView.mas_left).with.offset(35);
        make.size.mas_equalTo(CGSizeMake(28, 28));
        make.top.mas_equalTo(currentStep.mas_bottom).with.offset(kPaddingBetweenLabels-kPaddingImageView);
    }];
    [self appearanceForImageViews:@[numberImageView]];
    
    UILabel *numberDescriptionLabel = UILabel.new;
    numberDescriptionLabel.textColor = UIColor.whiteColor;
    numberDescriptionLabel.text = step;
    numberDescriptionLabel.numberOfLines = 2;
    numberDescriptionLabel.font = [UIFont boldSystemFontOfSize:15];
    [contentView addSubview:numberDescriptionLabel];
    
    [numberDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView.mas_left).with.offset(75);
        make.right.mas_equalTo(contentView.mas_right).with.offset(-10);
        make.top.mas_equalTo(currentStep.mas_bottom).with.offset(kPaddingBetweenLabels);
    }];
    
    
    return numberDescriptionLabel;
}


#pragma mark - Switch steps

- (UIView *)addTurnOnLockScreen:(NSInteger)position insertUnder:(UIView *)currentStep
{
    
    return [self addSwitchStep:STNotificationLocalizedString(@"notification.lockScreen")
                 atPosition:position
                insertUnder:currentStep];
}


- (UIView *)addTurnOnAllowNotifications:(NSInteger)position insertUnder:(UIView *)currentStep
{
    
    return [self addSwitchStep:STNotificationLocalizedString(@"notification.allowNotifications")
                    atPosition:position
                   insertUnder:currentStep];
}


-(UIView *)addSwitchStep:(NSString *)step atPosition:(NSInteger)position insertUnder:(UIView *)currentStep
{
    UILabel *numberLabel = UILabel.new;
    numberLabel.text = [NSString stringWithFormat:@"%ld.", (long)position];
    [contentView addSubview:numberLabel];
    
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView.mas_left).with.offset(10);
        make.right.mas_equalTo(contentView.mas_right).with.offset(-10);
        make.top.mas_equalTo(currentStep.mas_bottom).with.offset(kPaddingBetweenLabels);
    }];
    [self numberAppearanceForLables:@[numberLabel]];
    
    UILabel *descriptionLabel = UILabel.new;
    descriptionLabel.textColor = UIColor.whiteColor;
    descriptionLabel.text = [NSString stringWithFormat:STNotificationLocalizedString(@"notification.activate"),step];
    descriptionLabel.numberOfLines = 2;
    descriptionLabel.font = [UIFont boldSystemFontOfSize:15];
    [contentView addSubview:descriptionLabel];
    
    [descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView.mas_left).with.offset(35);
        make.right.mas_equalTo(contentView.mas_right).with.offset(-10);
        make.top.mas_equalTo(currentStep.mas_bottom).with.offset(kPaddingBetweenLabels);
    }];
    
    UIView *descriptionView = UIView.new;
    descriptionView.layer.cornerRadius = 8;
    descriptionView.layer.borderColor = UIColor.whiteColor.CGColor;
    descriptionView.layer.borderWidth = 1;
    [contentView addSubview:descriptionView];
    
    [descriptionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView.mas_left).with.offset(35);
        make.right.mas_equalTo(contentView.mas_right).with.offset(-35);
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(descriptionLabel.mas_bottom).with.offset(kPaddingBetweenViews);
    }];
    
    UILabel *descriptionLabelInDescriptionView = UILabel.new;
    descriptionLabelInDescriptionView.font = [UIFont boldSystemFontOfSize:15];
    descriptionLabelInDescriptionView.textColor = UIColor.whiteColor;
    descriptionLabelInDescriptionView.text = step;
    [descriptionLabelInDescriptionView setAdjustsFontSizeToFitWidth:YES];
    [descriptionView addSubview:descriptionLabelInDescriptionView];
    
    [descriptionLabelInDescriptionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(descriptionView.mas_left).with.offset(15);
        make.right.mas_equalTo(descriptionView.mas_right).with.offset(-70);
        make.top.mas_equalTo(descriptionView.mas_top).with.offset(0);
        make.bottom.mas_equalTo(descriptionView.mas_bottom).with.offset(0);
    }];
    
    STUISwitchView *numberSwitchView = STUISwitchView.new;
    [descriptionView addSubview:numberSwitchView];
    
    [numberSwitchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(descriptionView.mas_right).with.offset(-10);
        make.centerY.mas_equalTo(descriptionView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(45, 21));
    }];

    
    return descriptionView;
}

#pragma mark - SelecctionType

-(UIView*) addSelectionTypeAtPosition:(NSInteger)position insertUnder:(UIView *)currentStep
{
    UILabel *numberLabel = UILabel.new;
    numberLabel.text = [NSString stringWithFormat:@"%ld.", (long)position ];
    [contentView addSubview:numberLabel];
    
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView.mas_left).with.offset(10);
        make.right.mas_equalTo(contentView.mas_right).with.offset(-10);
        make.top.mas_equalTo(currentStep.mas_bottom).with.offset(kPaddingBetweenLabels/2);
    }];
    
    UILabel *descriptionLabel = UILabel.new;
    descriptionLabel.textColor = UIColor.whiteColor;
    descriptionLabel.text = STNotificationLocalizedString(@"notification.chooseBanner");
    descriptionLabel.numberOfLines = 2;
    descriptionLabel.font = [UIFont boldSystemFontOfSize:15];
    [contentView addSubview:descriptionLabel];
    
    [descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView.mas_left).with.offset(35);
        make.right.mas_equalTo(contentView.mas_right).with.offset(-10);
        make.top.mas_equalTo(currentStep.mas_bottom).with.offset(kPaddingBetweenLabels/2);
    }];
    
    UIView *descriptionView = UIView.new;
    descriptionView.layer.cornerRadius = 8;
    descriptionView.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.5].CGColor;
    descriptionView.layer.borderWidth = 1;
    [contentView addSubview:descriptionView];
    
    [descriptionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView.mas_left).with.offset(35);
        make.right.mas_equalTo(contentView.mas_right).with.offset(-35);
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(descriptionLabel.mas_bottom).with.offset(kPaddingBetweenViews);
    }];
    
    [contentView layoutIfNeeded];
    
    UILabel *noneLabel = UILabel.new;
    noneLabel.textColor = UIColor.lightGrayColor;
    noneLabel.text = STNotificationLocalizedString(@"notification.none");
    [noneLabel setAdjustsFontSizeToFitWidth:YES];
    noneLabel.font = [UIFont boldSystemFontOfSize:15];
    noneLabel.textAlignment = NSTextAlignmentCenter;
    [descriptionView addSubview:noneLabel];
    
    UILabel *bannerLabel = UILabel.new;
    bannerLabel.backgroundColor = UIColor.whiteColor;
    bannerLabel.clipsToBounds = YES;
    bannerLabel.layer.cornerRadius = 8;
    bannerLabel.textColor = UIColor.blackColor;
    bannerLabel.text = STNotificationLocalizedString(@"notification.banner");
    [bannerLabel setAdjustsFontSizeToFitWidth:YES];
    bannerLabel.font = [UIFont boldSystemFontOfSize:15];
    bannerLabel.textAlignment = NSTextAlignmentCenter;
    [descriptionView addSubview:bannerLabel];
    
    UILabel *hinweisLabel = UILabel.new;
    hinweisLabel.textColor = UIColor.lightGrayColor;
    hinweisLabel.text = STNotificationLocalizedString(@"notification.alert");
    [hinweisLabel setAdjustsFontSizeToFitWidth:YES];
    hinweisLabel.font = [UIFont boldSystemFontOfSize:15];
    hinweisLabel.textAlignment = NSTextAlignmentCenter;
    [descriptionView addSubview:hinweisLabel];
    
    [noneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(descriptionView.mas_left);
        make.centerY.mas_equalTo(descriptionView.mas_centerY);
        make.right.mas_equalTo(bannerLabel.mas_left);
        make.top.mas_equalTo(descriptionView.mas_top).with.offset(7);
        make.bottom.mas_equalTo(descriptionView.mas_bottom).with.offset(-7);
        make.width.mas_equalTo(@[noneLabel.mas_width,bannerLabel.mas_width]);
    }];
    
    [bannerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(noneLabel.mas_right);
        make.right.mas_equalTo(hinweisLabel.mas_left);
        make.top.mas_equalTo(descriptionView.mas_top).with.offset(7);
        make.bottom.mas_equalTo(descriptionView.mas_bottom).with.offset(-7);
        make.width.mas_equalTo(@[noneLabel.mas_width,bannerLabel.mas_width]);
    }];
    
    [hinweisLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bannerLabel.mas_right);
        make.top.mas_equalTo(descriptionView.mas_top).with.offset(7);
        make.bottom.mas_equalTo(descriptionView.mas_bottom).with.offset(-7);
        make.width.mas_equalTo(@[noneLabel.mas_width,bannerLabel.mas_width]);
        make.right.mas_equalTo(descriptionView.mas_right);
        make.centerY.mas_equalTo(descriptionView.mas_centerY);
    }];
    [self numberAppearanceForLables:@[numberLabel]];
    
    return descriptionView;
}

#pragma mark - Customization views

-(void)appearanceForImageViews:(NSArray*)imagesViews{
    for (UIImageView *imageView in imagesViews) {
        imageView.layer.cornerRadius = 8;
        imageView.backgroundColor = UIColor.whiteColor;
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeCenter;
        if (imageView.image.size.width > 28 &&
             imageView.image.size.height > 28) {
            
            imageView.contentMode = UIViewContentModeScaleAspectFill;
        }
        imageView.tintColor = UIColor.blackColor;
    }
}

-(void)numberAppearanceForLables:(NSArray*)labels{
    
    for (UILabel *label in labels) {
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = UIColor.darkGrayColor;
    }
}

-(void)goToSettings{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:url];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)exitButtonAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(BOOL)shouldAutorotate{
    return YES;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

#pragma mark - iOS versions control
-(BOOL) isiOS7OrLower
{
    return [[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] == NSOrderedAscending;
}
@end
