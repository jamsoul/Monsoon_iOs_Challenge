//
//  MCFoodPickerView.m
//  myChallenge
//
//  Created by Jorge Marino on 11/29/14.
//  Copyright (c) 2014 Jorge Marino. All rights reserved.
//

#pragma mark
#pragma mark Defines

#define MCFOODPICKERVIEW_HORIZONTAL_INSET 18
#define MCFOODPICKERVIEW_VERTICAL_INSET 72
#define MCFOODPICKERVIEW_SEGMENTS_RADIUS 134
#define MCFOODPICKERVIEW_SEGMENTS_H_SEPARATION 18
#define MCFOODPICKERVIEW_SEGMENTS_V_SEPARATION 10

#define MCFOODPICKERVIEW_IMAGE_CALENDAR @"MON_calendarIcon.png"
#define MCFOODPICKERVIEW_IMAGE_COMPASS  @"MON_compassIcon.png"
#define MCFOODPICKERVIEW_IMAGE_GO       @"MON_GO.png"
#define MCFOODPICKERVIEW_IMAGE_MENU     @"MON_menuIcon.png"
#define MCFOODPICKERVIEW_IMAGE_SEARCH   @"MON_searchIcon.png"
#define MCFOODPICKERVIEW_IMAGE_SHUFFLE  @"MON_shuffleIcon.png"
#define MCFOODPICKERVIEW_IMAGE_BUTTON   @"MON_button.png"

#import "MCFoodPickerView.h"
#import <AudioToolbox/AudioToolbox.h>

#pragma mark
#pragma mark Private Class

@interface MCFoodPickerView()
@property (nonatomic, retain) UIImage* backgroundImage;
@property (nonatomic, retain) UIButton* buttonShuffle;
@property (nonatomic, retain) UIButton* buttonGo;

// move next methods to a helper UI building class
-(UIButton*) buttonWithImageForNormalState:(NSString*) imageNormal rect:(CGRect)rect;
-(UIButton*) buttonWithImageForNormalState:(NSString*) imageNormal rect:(CGRect)rect background:(NSString*)background backSize:(CGSize)backSize;
@end

#pragma mark
#pragma mark Implementation

@implementation MCFoodPickerView
@synthesize backgroundImage = _backgroundImage;
@synthesize buttonGo = _buttonGo;
@synthesize buttonShuffle = _buttonShuffle;

#pragma mark
#pragma mark Initialization

- (void) dealloc
{
    NXReleaseAndNil(_backgroundImage);
    NXReleaseAndNil(_testRC);
    NXReleaseAndNil(_roundSegments);
    NXReleaseAndNil(_buttonShuffle);
    NXReleaseAndNil(_buttonGo);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"tap_event" object:nil];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        NSString* SegmentOptionsPath = [[NSBundle mainBundle] pathForResource:@"SegmentsOptions" ofType:@"plist"];
        
        NSArray* allOptions = [NSArray arrayWithContentsOfFile:SegmentOptionsPath];
        
        _roundSegments = [[NSMutableArray arrayWithCapacity:6] retain];
        
        [self createBackground];
        
        [self createRoundSegments:allOptions];
        
        UIButton* buttonMenu = [self buttonWithImageForNormalState:MCFOODPICKERVIEW_IMAGE_MENU rect:CGRectMake(286, 36, 23, 13)];
        [self addSubview:buttonMenu];
        [buttonMenu addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];

        UIButton* buttonCompass = [self buttonWithImageForNormalState:MCFOODPICKERVIEW_IMAGE_COMPASS rect:CGRectMake(104, 32, 23, 22)];
        [buttonCompass addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonCompass];

        UIButton* buttonCalendar = [self buttonWithImageForNormalState:MCFOODPICKERVIEW_IMAGE_CALENDAR rect:CGRectMake(62, 32, 23, 23)];
        [buttonCalendar addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonCalendar];

        UIButton* buttonSearch = [self buttonWithImageForNormalState:MCFOODPICKERVIEW_IMAGE_SEARCH rect:CGRectMake(19, 34, 22, 22)];
        [buttonSearch addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonSearch];
        
        self.buttonShuffle = [self buttonWithImageForNormalState:MCFOODPICKERVIEW_IMAGE_SHUFFLE rect:CGRectMake(120, 515, 27, 17) background:MCFOODPICKERVIEW_IMAGE_BUTTON backSize:CGSizeMake(50.0f, 50.0f)];
        [self.buttonShuffle addTarget:self action:@selector(buttonTapShuffle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.buttonShuffle];

        self.buttonGo = [self buttonWithImageForNormalState:MCFOODPICKERVIEW_IMAGE_GO rect:CGRectMake(173, 517, 27, 14) background:MCFOODPICKERVIEW_IMAGE_BUTTON backSize:CGSizeMake(50.0f, 50.0f)];
        [self.buttonGo addTarget:self action:@selector(buttonTapGo:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.buttonGo];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tapEventNotification:) name:@"tap_event" object:nil];
    }
    return self;
}

#pragma mark
#pragma mark Button Events

- (void) tapEventNotification:(id)sender
{
    SystemSoundID soundID;
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"caf"];
    NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
    
    AudioServicesCreateSystemSoundID ((CFURLRef)soundUrl, &soundID);
    AudioServicesPlaySystemSound(soundID);
}

- (void) buttonTap:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tap_event" object:nil];
}

- (void) buttonTapShuffle:(id)sender
{
    [self buttonTap:sender];
    
    for (NSUInteger k = 0; k < 6; k++)
    {
        MCRoundSegmentViewController* segment = [_roundSegments objectAtIndex:k];
        [segment shuffle];
    }
}

- (void) buttonTapGo:(id)sender
{
    [self buttonTap:sender];

    NSMutableArray* retSet = [NSMutableArray arrayWithCapacity:6];
    
    for (NSUInteger k = 0; k < 6; k++)
    {
        MCRoundSegmentViewController* segment = [_roundSegments objectAtIndex:k];
        [retSet addObject:[segment selectedOption]];
    }
    
    if (self.delegate)
    {
        [self.delegate MCFoodPickerView_DidFinish:retSet];
    }
}

#pragma mark
#pragma mark Objects Creation

- (CGRect)rectForSegment:(NSUInteger)k
{
    NSUInteger column = k % 2;
    NSUInteger row = k / 2;
    
    CGRect quad = CGRectMake(0, 0, MCFOODPICKERVIEW_SEGMENTS_RADIUS, MCFOODPICKERVIEW_SEGMENTS_RADIUS);
    
    CGRect rect = CGRectOffset(quad, MCFOODPICKERVIEW_HORIZONTAL_INSET + column * MCFOODPICKERVIEW_SEGMENTS_RADIUS + (column * MCFOODPICKERVIEW_SEGMENTS_H_SEPARATION),
                                     MCFOODPICKERVIEW_VERTICAL_INSET + row * MCFOODPICKERVIEW_SEGMENTS_RADIUS + (row*MCFOODPICKERVIEW_SEGMENTS_V_SEPARATION));
    return rect;
}

- (void)createRoundSegments:(NSArray *)allOptions
{
    for (NSUInteger k = 0; k < 6; k++)
    {
        CGRect rect = [self rectForSegment:k];
        MCRoundSegmentViewController* rVC = [[MCRoundSegmentViewController alloc] initWithFrame:rect options:allOptions[k]];
        [_roundSegments addObject:rVC];
        [self addSubview:rVC.view];
        NXReleaseAndNil(rVC);
    }
}

- (void)createBackground
{
    self.backgroundImage = [UIImage imageNamed:@"background.png"];
    
    UIImageView* backgroundView = [[UIImageView alloc] initWithImage:self.backgroundImage];
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:backgroundView];
    [backgroundView setUserInteractionEnabled:NO];
    
    NXReleaseAndNil(backgroundView);
}

-(UIButton*) buttonWithImageForNormalState:(NSString*) imageNormal rect:(CGRect)rect;
{
    ASSERT(imageNormal);
    
    UIImage* imgNormal = [UIImage imageNamed:imageNormal];
    ASSERT_CLASS(imgNormal, UIImage);
    
    UIButton* retButton = [[UIButton alloc] init];
    ASSERT_CLASS(retButton, UIButton);
    
    [retButton setBackgroundImage:imgNormal forState:UIControlStateNormal];
    [retButton setFrame:rect];
    [retButton setShowsTouchWhenHighlighted:YES];
    return [retButton autorelease];
}

-(UIButton*) buttonWithImageForNormalState:(NSString*) imageNormal rect:(CGRect)rect background:(NSString*)background backSize:(CGSize)backSize
{
    UIButton* retButton = [self buttonWithImageForNormalState:imageNormal rect:rect];
    UIImage* imgBack = [UIImage imageNamed:background];
    ASSERT_CLASS(imgBack, UIImage);
    
    CGRect rectBack = CGRectMake(-(backSize.width-rect.size.width)*0.5f , -(backSize.height-rect.size.height)*0.5f, backSize.width, backSize.height);
    
    UIImageView* backView = [[UIImageView alloc] initWithFrame:rectBack];
    [backView setImage:imgBack];
    [retButton addSubview:backView];
    [retButton sendSubviewToBack:backView];
    NXReleaseAndNil(backView);
    return retButton;
}

@end
