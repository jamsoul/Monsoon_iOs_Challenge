//
//  MCAppDelegate.h
//  myChallenge
//
//  Created by Jorge Marino on 11/29/14.
//  Copyright (c) 2014 Jorge Marino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCFoodPickerViewController.h"

@interface MCAppDelegate : UIResponder <UIApplicationDelegate, MCFoodPickerViewControllerDelegate>
{
    MCFoodPickerViewController* _mainVC;
}

@property (nonatomic, retain) UIWindow *window;


@end
