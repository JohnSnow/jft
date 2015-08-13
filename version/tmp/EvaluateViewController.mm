//
//  EvaluateView.cpp
//  dgame
//
//  Created by isaacwang on 14-6-18.
//
//

#include "EvaluateViewController.h"
#import "Config.h"

@implementation EvaluateViewController

@synthesize appid;

@synthesize indicatorView;

+ (EvaluateViewController*)initWithAppid:(NSString*)aid
{
    EvaluateViewController* evc = [[EvaluateViewController alloc] initWithNibName:nil bundle:nil];
    evc.appid = aid;
    
    evc.view.layer.cornerRadius = 6;
    evc.view.layer.masksToBounds = YES;
    
    NSArray *viewArray = evc.view.subviews;
    for(UIView *subView in viewArray)
    {
        if(subView.tag == 11 or
           subView.tag == 12 or
           subView.tag == 13 or
           subView.tag == 14)
        {
            subView.layer.cornerRadius = 6;
            subView.layer.masksToBounds = YES;
            [subView.layer setBorderWidth:1.0];
            [subView.layer setBorderColor:CGColorCreate(CGColorSpaceCreateDeviceRGB(), (CGFloat[]){0.6,0.6,0.6,0.5})];
        }
    }
    
    return evc;
}

- (void)refreshViewText:(NSString*)titleText text1:(NSString*)buttonText1 text2:(NSString*)buttonText2 text3:(NSString*)buttonText3
{
    NSArray *viewArray = self.view.subviews;
    for(UIView *subView in viewArray)
    {
        NSInteger tag = subView.tag;
        switch (tag) {
            case 11:
                ((UILabel*)subView).text = titleText;
                break;
                
            case 12:
                [((UIButton*)subView) setTitle:buttonText1 forState:UIControlStateNormal];
                [((UIButton*)subView) setTitle:buttonText1 forState:UIControlStateHighlighted];
                break;
                
            case 13:
                [((UIButton*)subView) setTitle:buttonText2 forState:UIControlStateNormal];
                [((UIButton*)subView) setTitle:buttonText2 forState:UIControlStateHighlighted];
                break;
                
            case 14:
                [((UIButton*)subView) setTitle:buttonText3 forState:UIControlStateNormal];
                [((UIButton*)subView) setTitle:buttonText3 forState:UIControlStateHighlighted];
                break;
                
            default:
                break;
        }
    }
}

- (void)refreshFrame
{
    NSInteger width = 280;
    NSInteger height = 255;
    
    self.view.superview.bounds = CGRectMake(0, 0, width, height);
    self.view.superview.layer.cornerRadius = 6;
    self.view.superview.layer.masksToBounds = YES;
}

- (IBAction)doClickGo:(id)sender {
    [self openEvaluate];
}

- (IBAction)doClickCancel:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
//    [self doRemove];
}

- (void)doRemove
{
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
}

- (void)openEvaluate
{
    Config *config = [Config sharedConfig];
    Class storevc = NSClassFromString(@"SKStoreProductViewController");
    if(storevc != nil)
    {
        SKStoreProductViewController *controller = [[SKStoreProductViewController alloc] init];
        controller.delegate = self;
        
        [self dismissViewControllerAnimated:YES completion:nil];
        [self loadIndicatorView];
        [controller loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : self.appid} completionBlock:^(BOOL result, NSError *error) {
            if(result)
            {
//                [self presentViewController:controller animated:YES completion:nil];
                [config.rootView presentViewController:controller animated:YES completion:nil];
                [self dismissIndicatorView];
                NSLog(@"-->>storeProductView didLoaded");
            }
            else
            {
                NSLog(@"error: %@ , errorInfo : %@" , error , [error userInfo]);
            }
        }];
    }
    else
    {
        NSString *addr = @"itms-apps://itunes.apple.com/cn/app/dao-ta-chuan-qi-dong-zuo-ka/id793077082?mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:addr]];
    }
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:^(void)
     {
//         [self dismissViewControllerAnimated:YES completion:nil];
     }];
    NSLog(@"-->>storeProductView productViewControllerDidFinish");
}

- (void)loadIndicatorView
{
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.indicatorView.tag = 80;
    self.indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    self.indicatorView.backgroundColor = [UIColor blackColor];
    self.indicatorView.alpha = 0.5;
    self.indicatorView.layer.cornerRadius = 6;
    self.indicatorView.layer.masksToBounds = YES;
    
//    [self.indicatorView setCenter:CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0)];
//    [self.indicatorView startAnimating];
//    [self.view addSubview:self.indicatorView];
    
    Config* config = [Config sharedConfig];
    CGSize size = [[UIScreen mainScreen] bounds].size;
    [self.indicatorView setCenter:CGPointMake(size.height / 2.0, size.width / 2.0)];
    [self.indicatorView startAnimating];
    [config.rootView.view addSubview:self.indicatorView];
}

- (void)dismissIndicatorView
{
    if(self.indicatorView)
    {
        [self.indicatorView removeFromSuperview];
        [self.indicatorView release];
    }
}

@end


