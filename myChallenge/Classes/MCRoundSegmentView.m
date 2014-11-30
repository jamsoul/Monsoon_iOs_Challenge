//
//  MCRoundSegmentView.m
//  myChallenge
//
//  Created by Jorge Marino on 11/29/14.
//  Copyright (c) 2014 Jorge Marino. All rights reserved.
//

#import "MCRoundSegmentView.h"

#pragma mark
#pragma mark Macros

#define DEG_TO_RAD(x) (x*M_PI/180.0f)
#define MCROUNDSEGMENT_SEGMENT_DIVISION_ARC 13

#pragma mark
#pragma mark Private Class

@interface MCRoundSegmentView()
@property (nonatomic, retain) NSArray* options;
@property (nonatomic, retain) NSMutableArray* beziers;
@property (nonatomic, retain) UIBezierPath* bezierCircle;
@property (nonatomic, retain) UIColor* colorSelected;
@property (nonatomic, retain) UIColor* colorUnselected;
@property (nonatomic, retain) UILabel* titleLabel;
@property (nonatomic, retain) UITapGestureRecognizer* tapRecognizer;
@end

#pragma mark
#pragma mark Implementation

@implementation MCRoundSegmentView

@synthesize options = _options;
@synthesize beziers = _beziers;
@synthesize selectedIndex = _selectedIndex;
@synthesize bezierCircle = _bezierCircle;
@synthesize colorSelected = _colorSelected;
@synthesize colorUnselected = _colorUnselected;
@synthesize titleLabel = _titleLabel;

#pragma mark
#pragma mark Initialization

-(void) dealloc
{
    NXReleaseAndNil(_options);
    NXReleaseAndNil(_beziers);
    NXReleaseAndNil(_bezierCircle);
    NXReleaseAndNil(_colorUnselected);
    NXReleaseAndNil(_colorSelected);
    NXReleaseAndNil(_titleLabel);
    NXReleaseAndNil(_tapRecognizer);
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame options:(NSArray*)options
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.options = options;
        self.beziers = [NSMutableArray arrayWithCapacity:[options count]];
        self.colorUnselected   = [UIColor colorWithRed:0.4 green:0 blue:0.58 alpha:1];
        self.colorSelected     = [UIColor colorWithRed:1 green:0.4 blue:0.4 alpha:1];
        [self setupArcBeziers];
        [self setBackgroundColor:[UIColor clearColor]];
        
        CGRect labelRect = CGRectMake(10, (frame.size.height - 30) * 0.5f, frame.size.width - 20.0f, 30.0f);
        self.titleLabel = [[UILabel alloc] initWithFrame:labelRect];
        self.titleLabel.font = [UIFont fontWithName:@"SourceSansPro-Regular" size:17];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
    
        self.userInteractionEnabled = YES;

        self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        self.tapRecognizer.numberOfTapsRequired = 1;
        [self addGestureRecognizer:self.tapRecognizer];

        self.selectedIndex = 0;
    }
    return self;
}

#pragma mark
#pragma mark Properties Functionality

-(void) setSelectedIndex:(NSUInteger)selectedIndex
{
    if (selectedIndex < [self.options count])
    {
        NSString* targetString = [self.options objectAtIndex:selectedIndex];
        self.titleLabel.text = [targetString uppercaseString];
    }
    
    _selectedIndex = selectedIndex;
    
    [self setNeedsDisplay];
}

#pragma mark
#pragma mark Button Events


-(void) onTap:(id)sender
{
    self.selectedIndex = (_selectedIndex+1)%[self.options count];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tap_event" object:nil];
}

#pragma mark
#pragma mark Drawing Routines


-(void) setupArcBeziers
{
    NSUInteger arcCount = [self.options count];

    CGRect viewBounds = CGRectInset(self.bounds, 1, 1);
    CGPoint middle = CGPointMake(self.bounds.size.width*0.5f, self.bounds.size.height*0.5f);
    CGFloat radius = viewBounds.size.width*0.5f;

    CGFloat arcLength = (360 - MCROUNDSEGMENT_SEGMENT_DIVISION_ARC * arcCount) / arcCount;
    CGFloat startAngle = MCROUNDSEGMENT_SEGMENT_DIVISION_ARC * 0.5f;

    for (NSUInteger k=0; k<arcCount; k++)
    {
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:middle
                                                             radius:radius
                                                        startAngle:DEG_TO_RAD(-startAngle)
                                                          endAngle:DEG_TO_RAD(-(startAngle+arcLength))
                                                          clockwise:NO];
        path.lineWidth = 1;
        [self.beziers addObject:path];
        startAngle -= arcLength + MCROUNDSEGMENT_SEGMENT_DIVISION_ARC;
    }
    
    self.bezierCircle = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, 5, 5)];
    
}

- (void)drawRect:(CGRect)rect
{
    [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2] setFill];
    
    [self.bezierCircle fill];
    
    for (NSUInteger k=0; k<[self.options count]; k++)
    {
        if (k == self.selectedIndex)
        {
            [self.colorSelected setStroke];
        }
        else
        {
            [self.colorUnselected setStroke];
        }

        UIBezierPath* path = self.beziers[k];
        [path stroke];
    }
}

@end
