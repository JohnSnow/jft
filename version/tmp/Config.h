//
//  Config.h
//  dgame
//
//  Created by isaacwang on 14-6-18.
//
//

#import <Foundation/Foundation.h>

@interface Config : NSObject
{
    
}

@property (retain) UIViewController *rootView;

@property (retain) NSString* evcTitleText;
@property (retain) NSString* evcButtonText1;
@property (retain) NSString* evcButtonText2;
@property (retain) NSString* evcButtonText3;

+(Config*)sharedConfig;
-(void)setEVCTextConfig:(NSString*)t1 button1:(NSString*)bt1 button2:(NSString*)bt2 button3:(NSString*)bt3;

@end