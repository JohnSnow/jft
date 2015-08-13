//
//  EvaluateView.h
//  dgame
//
//  Created by isaacwang on 14-6-18.
//
//

#ifndef __EvaluateViewController__
#define __EvaluateViewController__

#import <StoreKit/StoreKit.h>

@interface EvaluateViewController : UIViewController<SKStoreProductViewControllerDelegate>
{
}

@property (retain) NSString* appid;

@property (retain) UIActivityIndicatorView *indicatorView;

+ (EvaluateViewController*)initWithAppid:(NSString*) appid;
- (void)refreshViewText:(NSString*)titleText text1:(NSString*)buttonText1 text2:(NSString*)buttonText2 text3:(NSString*)buttonText3;
- (void)refreshFrame;

@end

#endif