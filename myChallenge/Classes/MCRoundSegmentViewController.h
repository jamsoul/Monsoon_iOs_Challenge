//
//  MCRoundSegmentViewController.h
//  myChallenge
//
//  Created by Jorge Marino on 11/29/14.
//  Copyright (c) 2014 Jorge Marino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCRoundSegmentView.h"


@interface MCRoundSegmentViewController : UIViewController
{
    MCRoundSegmentView* _currentView;
    CGRect _frame;
}

-(id)initWithFrame:(CGRect)frame options:(NSArray *)options;
-(NSUInteger) selectedIndex;
-(NSString*) selectedOption;
-(void) shuffle;
@end
