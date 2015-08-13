//
//  Config.m
//  dgame
//
//  Created by isaacwang on 14-6-18.
//
//

#import "Config.h"

static Config* config;

@implementation Config

@synthesize rootView;
@synthesize evcTitleText;
@synthesize evcButtonText1;
@synthesize evcButtonText2;
@synthesize evcButtonText3;

+(Config*)sharedConfig
{
    if(config == nil)
    {
        config = [[Config alloc] init];
        config.evcTitleText = @"    觉得我们的游戏怎么样？去AppStore给我们评个分吧";
        config.evcButtonText1 = @"立即前往";
        config.evcButtonText2 = @"现在不要";
        config.evcButtonText3 = @"不再提醒";
    }
    
    return config;
}

-(void)setEVCTextConfig:(NSString*)t1 button1:(NSString*)bt1 button2:(NSString*)bt2 button3:(NSString*)bt3
{
    self.evcTitleText = t1;
    self.evcButtonText1 = bt1;
    self.evcButtonText2 = bt2;
    self.evcButtonText3 = bt3;
}

@end
