//
//  ViewController.m
//  realclock
//
//  Created by Alessandro Giacomella on 02/11/15.
//  Copyright © 2015 AleGiac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *hour1Label;
@property (weak, nonatomic) IBOutlet UILabel *hour2Label;
@property (weak, nonatomic) IBOutlet UILabel *separator1Label;
@property (weak, nonatomic) IBOutlet UILabel *minute1Label;
@property (weak, nonatomic) IBOutlet UILabel *minute2Label;
@property (weak, nonatomic) IBOutlet UILabel *separator2Label;
@property (weak, nonatomic) IBOutlet UILabel *second1Label;
@property (weak, nonatomic) IBOutlet UILabel *second2Label;

@end

@implementation ViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];

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
