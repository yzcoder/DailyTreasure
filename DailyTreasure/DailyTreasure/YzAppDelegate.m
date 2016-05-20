//
//  AppDelegate.m
//  DailyTreasure
//
//  Created by 初号机 on 16/3/25.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import "YzAppDelegate.h"
#import "YzHomeViewController.h"
#import "YzLeftViewController.h"
@interface YzAppDelegate ()

@property(nonatomic, strong) UIImageView *launchBackImageView;
@property(nonatomic, strong) UIImageView *launchFontImageView;

@end

@implementation YzAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:kScreenBounds];
    [self.window makeKeyAndVisible];
    YzHomeViewController *homeViewController = [[YzHomeViewController alloc] init];
    YzLeftViewController *leftViewController = [[YzLeftViewController alloc] init];
    self.drawerViewController = [YzDrawerViewController creatDrawerViewControllerWithHomeViewController:homeViewController leftViewController:leftViewController];
    UINavigationController *narigation = [[UINavigationController alloc] initWithRootViewController:    self.drawerViewController];
    self.window.rootViewController = narigation;
    [self setLauchView];
    


    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)setLauchView {
    self.launchFontImageView = [[UIImageView alloc] initWithFrame:kScreenBounds];
    [self.window addSubview:self.launchFontImageView];
    
    self.launchBackImageView = [[UIImageView alloc] initWithFrame:kScreenBounds];
    self.launchBackImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Default@2x" ofType:@"png"]];
    [self.window addSubview:self.launchBackImageView];
    
    [YzHttpOperation getRequestWithURL:kGetLaunchImageURL parameters:nil success:^(id responseObject) {
        [_launchFontImageView sd_setImageWithURL:[NSURL URLWithString:responseObject[@"img"]]];
        
        [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"img"] forKey:kLaunchViewImageURL];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [UIView animateWithDuration:2.5f animations:^{
            self.launchBackImageView.alpha = 0.f;
            self.launchFontImageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            [self.launchBackImageView removeFromSuperview];
            [self.launchFontImageView removeFromSuperview];
        }];
    } failure:^(NSError * _Nonnull error) {
        [_launchFontImageView sd_setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] objectForKey:kLaunchViewImageURL]]];
        [UIView animateWithDuration:2.5f animations:^{
            self.launchBackImageView.alpha = 0.f;
            self.launchFontImageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            [self.launchBackImageView removeFromSuperview];
            [self.launchFontImageView removeFromSuperview];
        }];
    }];
    
 
}


@end
