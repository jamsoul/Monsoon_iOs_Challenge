//
//  MCFoodPickerView.h
//  myChallenge
//
//  Created by Jorge Marino on 11/29/14.
//  Copyright (c) 2014 Jorge Marino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCRoundSegmentViewController.h"

@protocol MCFoodPickerViewDelegate <NSObject>

-(void)MCFoodPickerView_DidFinish:(NSMutableArray*)options;

@end

@interface MCFoodPickerView : UIView
{
    NSMutableArray* _roundSegments;
    MCRoundSegmentViewController* _testRC;
}

@property (nonatomic, assign) id<MCFoodPickerViewDelegate> delegate;

@end
