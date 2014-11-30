//
//  MCRoundSegmentView.h
//  myChallenge
//
//  Created by Jorge Marino on 11/29/14.
//  Copyright (c) 2014 Jorge Marino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCRoundSegmentView : UIView

- (id)initWithFrame:(CGRect)frame options:(NSArray*)options;

@property (nonatomic, assign) NSUInteger selectedIndex;

@end
