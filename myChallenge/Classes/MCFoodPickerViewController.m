//
//  MFoodPickerViewController.m
//  myChallenge
//
//  Created by Jorge Marino on 11/29/14.
//  Copyright (c) 2014 Jorge Marino. All rights reserved.
//

#import "MCFoodPickerViewController.h"

@implementation MCFoodPickerViewController

-(void) dealloc
{
    NXReleaseAndNil(_currentView);
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _currentView = [[MCFoodPickerView alloc] initWithFrame:self.view.bounds];
    _currentView.delegate = self;
    [self.view addSubview:_currentView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) MCFoodPickerView_DidFinish:(NSMutableArray *)options
{
    if (self.delegate)
    {
        [self.delegate MCFoodPickerViewController_DidFinish:options];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
