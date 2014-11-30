//
//  MCRoundSegmentViewController.m
//  myChallenge
//
//  Created by Jorge Marino on 11/29/14.
//  Copyright (c) 2014 Jorge Marino. All rights reserved.
//

#import "MCRoundSegmentViewController.h"

@interface MCRoundSegmentViewController ()
@property (nonatomic, retain) NSArray* options;
@end

@implementation MCRoundSegmentViewController
@synthesize options = _options;

-(void) dealloc
{
    NXReleaseAndNil(_currentView);
    [super dealloc];
}

-(id)initWithFrame:(CGRect)frame options:(NSArray *)aOptions
{
    self = [super init];
    
    if (self)
    {
        _frame = frame;
        self.options = aOptions;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _currentView = [[MCRoundSegmentView alloc] initWithFrame:_frame options:self.options];

    self.view = _currentView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger) selectedIndex
{
    return [_currentView selectedIndex];
}

-(void) shuffle
{
    _currentView.selectedIndex = rand()%[self.options count];
}

-(NSString*) selectedOption
{
    return [self.options objectAtIndex:self.selectedIndex];
}

@end
