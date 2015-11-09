//
//  ViewController.m
//  realclock
//
//  Created by Alessandro Giacomella on 02/11/15.
//  Copyright © 2015 AleGiac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// Outlets
@property (weak, nonatomic) IBOutlet UILabel *hour1Label;
@property (weak, nonatomic) IBOutlet UILabel *hour2Label;
@property (weak, nonatomic) IBOutlet UILabel *separator1Label;
@property (weak, nonatomic) IBOutlet UILabel *minute1Label;
@property (weak, nonatomic) IBOutlet UILabel *minute2Label;
@property (weak, nonatomic) IBOutlet UILabel *separator2Label;
@property (weak, nonatomic) IBOutlet UILabel *second1Label;
@property (weak, nonatomic) IBOutlet UILabel *second2Label;

// Content and banner views
@property (nonatomic, weak) IBOutlet UIView *contentView;
@property (nonatomic, strong) ADBannerView *bannerView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *bottomConstraint;


@end

@implementation ViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];

    // AdBanner
    if ([ADBannerView instancesRespondToSelector:@selector(initWithAdType:)]) {
        _bannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    }
    else {
        _bannerView = [[ADBannerView alloc] init];
    }
    self.bannerView.delegate = self;
    [self.view addSubview:self.bannerView];
    
    // Shows the time in view
    [self showTime];
    
    // Setup the timer
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    NSTimer *clockTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(showTime) userInfo:nil repeats:YES];
    [runloop addTimer:clockTimer forMode:NSRunLoopCommonModes];
    [runloop addTimer:clockTimer forMode:UITrackingRunLoopMode];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)layoutAnimated:(BOOL)animated {
    CGRect contentFrame = self.view.bounds;
    
    // all we need to do is ask the banner for a size that fits into the layout area we are using
    CGSize sizeForBanner = [self.bannerView sizeThatFits:contentFrame.size];
    
    // compute the ad banner frame
    CGRect bannerFrame = self.bannerView.frame;
    if (self.bannerView.bannerLoaded) {
        
        // bring the ad into view
        contentFrame.size.height -= sizeForBanner.height;   // shrink down content frame to fit the banner below it
        bannerFrame.origin.y = contentFrame.size.height;
        bannerFrame.size.height = sizeForBanner.height;
        bannerFrame.size.width = sizeForBanner.width;
        
        // if the ad is available and loaded, shrink down the content frame to fit the banner below it,
        // we do this by modifying the vertical bottom constraint constant to equal the banner's height
        //
        NSLayoutConstraint *verticalBottomConstraint = self.bottomConstraint;
        verticalBottomConstraint.constant = sizeForBanner.height;
        [self.view layoutSubviews];
        
    }
    else {
        // hide the banner off screen further off the bottom
        bannerFrame.origin.y = contentFrame.size.height;
    }
    
    [UIView animateWithDuration:animated ? 0.25 : 0.0 animations:^{
        [self.contentView layoutIfNeeded];
        self.bannerView.frame = bannerFrame;
    }];
}

- (void)viewDidLayoutSubviews {
    [self layoutAnimated:[UIView areAnimationsEnabled]];
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    [self layoutAnimated:YES];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"didFailToReceiveAdWithError %@", error);
    [self layoutAnimated:YES];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
}




/**
 *    @author Alessandro Giacomella <alessandro.giacomella@gmail.com>, 15-11-09 14:11:00
 *
 *    Display time in the main view, loading from new NSDate
 *
 *    @since 1.0
 */
-(void)showTime
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"hh:mm:ss a"];
    NSString *time = [formatter stringFromDate:date];
    
    _hour1Label.text = [time substringWithRange:NSMakeRange(0,1)];
    _hour2Label.text = [time substringWithRange:NSMakeRange(1,1)];
    
    _minute1Label.text = [time substringWithRange:NSMakeRange(3,1)];
    _minute2Label.text = [time substringWithRange:NSMakeRange(4,1)];
    
    _second1Label.text = [time substringWithRange:NSMakeRange(6,1)];
    _second2Label.text = [time substringWithRange:NSMakeRange(7,1)];
    
}

@end
