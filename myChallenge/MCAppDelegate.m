//
//  MCAppDelegate.m
//  myChallenge
//
//  Created by Jorge Marino on 11/29/14.
//  Copyright (c) 2014 Jorge Marino. All rights reserved.
//

#import "MCAppDelegate.h"

@implementation MCAppDelegate

-(void) dealloc
{
    NXReleaseAndNil(_window);
    NXReleaseAndNil(_mainVC);
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    _mainVC = [[MCFoodPickerViewController alloc] init];
    self.window.rootViewController = _mainVC;
    _mainVC.delegate = self;
    [self.window addSubview:_mainVC.view];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark
#pragma mark MCFoodPickerViewDelegate

-(void) MCFoodPickerViewController_DidFinish:(NSArray *)option
{
    NSString* alertText = [NSString stringWithFormat:@"Your selection is: %@", [option componentsJoinedByString:@", "]];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Go" message:alertText delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
    [alert show];
    NXReleaseAndNil(alert);
}

@end
