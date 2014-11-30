//
//  MCFoodPickerViewController.h
//  myChallenge
//
//  Created by Jorge Marino on 11/29/14.
//  Copyright (c) 2014 Jorge Marino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCFoodPickerView.h"

@protocol MCFoodPickerViewControllerDelegate <NSObject>

-(void)MCFoodPickerViewController_DidFinish:(NSMutableArray*)options;

@end

@interface MCFoodPickerViewController : UIViewController <MCFoodPickerViewDelegate>
{
    MCFoodPickerView* _currentView;
}

@property (nonatomic, assign) id<MCFoodPickerViewControllerDelegate> delegate;

@end
