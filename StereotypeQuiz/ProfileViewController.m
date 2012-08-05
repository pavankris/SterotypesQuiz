//
//  ProfileViewController.m
//  StereotypeQuiz
//
//  Created by pavan krishnamurthy on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

@synthesize profiledata = _profiledata;
@synthesize profileImage = _profileImage;
@synthesize profileName = _profileName;
@synthesize Complexstyp = _Complexstyp;
@synthesize intensestyp = _intensestyp;
@synthesize rhythmicstyp = _rhythmicstyp;
@synthesize upbeatstyp = _upbeatstyp;
@synthesize mmtbValLabel = _mmtbValLabel;

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
    NSLog(@"Data=%@",self.profiledata);
    personal_score = 0;
    [self.profileName setText:[self.profiledata objectForKey:@"user"]];
    
    [self.Complexstyp setText:[NSString stringWithFormat:@"%@%@",
                               [[self.profiledata objectForKey:@"styp"]objectForKey:@"complex"],
                               @"%"
                               ]
     ];
    
    [self.intensestyp setText:[NSString stringWithFormat:@"%@%@",
                               [[self.profiledata objectForKey:@"styp"]objectForKey:@"intense"],
                               @"%"
                               ]
     ];
    
    [self.rhythmicstyp setText:[NSString stringWithFormat:@"%@%@",
                               [[self.profiledata objectForKey:@"styp"]objectForKey:@"rhythmic"],
                               @"%"
                               ]
     ];
    
    [self.upbeatstyp setText:[NSString stringWithFormat:@"%@%@",
                               [[self.profiledata objectForKey:@"styp"]objectForKey:@"upbeat"],
                               @"%"
                               ]
     ];
    [self.mmtbValLabel setText:[self.profiledata objectForKey:@"mmb"]];
    /*[self.intensestyp setText:[self.profiledata objectForKey:@"rhythmic"]];
    [self.upbeatstyp setText:[self.profiledata objectForKey:@"upbeat"]];*/
    
    NSLog(@"%f",self.view.frame.size.width);
    NSLog(@"%f",self.view.frame.size.height);
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setProfileImage:nil];
    [self setProfileName:nil];
    [self setComplexstyp:nil];
    [self setIntensestyp:nil];
    [self setRhythmicstyp:nil];
    [self setUpbeatstyp:nil];
    [self setMmtbValLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
