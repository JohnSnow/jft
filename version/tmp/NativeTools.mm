//
//  NativeTools.m
//  dgame
//
//  Created by isaacwang on 14-3-19.
//
//

#include "NativeTools.h"
#import "Config.h"
#import "EvaluateViewController.h"

void NativeTools::OpenURL(const char* addr)
{
    NSString* nsaddr = [[NSString alloc] initWithUTF8String:addr];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:nsaddr]];
}

void NativeTools::AddNotification(const char* key , const char* text , const char* tag , long firstDate)
{
    CancelNotification(key);
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    NSString *nsKey = [[NSString alloc]initWithUTF8String:key];
    NSString *nsText = [[NSString alloc] initWithUTF8String:text];
    NSString *nsTag = [[NSString alloc] initWithUTF8String:tag];
    NSTimeInterval nsFirstDate = [[[NSNumber alloc] initWithLong:firstDate] doubleValue];
    
    if (notification != nil) {
        notification.fireDate = [[NSDate alloc] initWithTimeIntervalSince1970:nsFirstDate];
        notification.timeZone = [NSTimeZone defaultTimeZone];
        NSLog(@"%@" , notification.fireDate);
               
        if( [nsTag isEqualToString:@"once"] )
        {
        }
        else if( [nsTag isEqualToString:@"minute"] )
        {
            notification.repeatInterval = kCFCalendarUnitMinute;
        }
        else if( [nsTag isEqualToString:@"day"] )
        {
            notification.repeatInterval = kCFCalendarUnitDay;
        }
        else if( [nsTag isEqualToString:@"month"] )
        {
            notification.repeatInterval = kCFCalendarUnitMonth;
        }
        
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.alertBody = nsText;
        
        NSDictionary* infoDic = [NSDictionary dictionaryWithObject:nsKey forKey:@"id"];
        notification.userInfo = infoDic;
        
        notification.applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}

void NativeTools::CancelNotification(const char *key)
{
    NSString *nsKey = [[NSString alloc] initWithUTF8String:key];
    
    NSArray *nts = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for( UILocalNotification* n in nts )
    {
        if ([[n.userInfo objectForKey:@"id"] isEqualToString:nsKey]) {
            [[UIApplication sharedApplication] cancelLocalNotification:n];
        }
    }
}

void NativeTools::setEVCTextConfig(const char *titleText, const char *buttonText1, const char *buttonText2, const char *buttonText3)
{
    Config *config = [Config sharedConfig];
    config.evcTitleText = [[NSString alloc] initWithUTF8String:titleText];
    config.evcButtonText1 = [[NSString alloc] initWithUTF8String:buttonText1];
    config.evcButtonText2 = [[NSString alloc] initWithUTF8String:buttonText2];
    config.evcButtonText3 = [[NSString alloc] initWithUTF8String:buttonText3];
}

void NativeTools::pushEvaluateView(const char *appid)
{
    Config *config = [Config sharedConfig];
    NSString *nsappid = [[NSString alloc] initWithUTF8String:appid];
    EvaluateViewController *evc = [EvaluateViewController initWithAppid:nsappid];
    [evc refreshViewText:config.evcTitleText text1:config.evcButtonText1 text2:config.evcButtonText2 text3:config.evcButtonText3];
    
    evc.modalPresentationStyle = UIModalPresentationFormSheet;
    evc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [config.rootView presentViewController:evc animated:YES completion:nil];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            evc.view.backgroundColor = [UIColor clearColor];
            evc.view.bounds = CGRectMake(0,0,285,255);
        }
        else
        {
            evc.view.superview.bounds = CGRectMake(0,0,285,255);
        }
    }
    [evc refreshFrame];
}

double NativeTools::absoluteTimeGetCurrent()
{
    return CFAbsoluteTimeGetCurrent();
}