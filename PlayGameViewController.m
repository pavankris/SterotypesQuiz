//
//  PlayGameViewController.m
//  StereotypeQuiz
//
//  Created by pavan krishnamurthy on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlayGameViewController.h"
#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "AFJSONRequestOperation.h"
//#import "CustomBadge.h"

@interface PlayGameViewController ()

@end

@implementation PlayGameViewController
@synthesize option1Song;
@synthesize option1artist;
@synthesize option2Song;
@synthesize option2artist;

@synthesize option3Song;
@synthesize option3artist;

@synthesize option4Song;
@synthesize option4artist;

@synthesize questionText;
@synthesize option1Button;
@synthesize option2Button;
@synthesize option3Button;
@synthesize option4Button;
@synthesize scoreLabel;
@synthesize multiplierLabel;
@synthesize lifeLineButton;

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
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    lifeline_remaining = 2;
    totalscore = 0;
    multiplier = 1;
    question_num = 0;

    NSData *ImagenUrl = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://a5.mzstatic.com/us/r1000/025/Music/c0/c4/7f/mzi.dfvpkjls.30x30-50.jpg"]];
    
    [questionText setText:@"What Song do i Like"];
    
    [option1Button setImage:[UIImage imageWithData:ImagenUrl] forState:UIControlStateNormal];
    [self loadQuestions];
    //[option1Button setTitle:@"Hiii" forState:UIControlStateNormal];
    
    

   
	// Do any additional setup after loading the view.
}

- (void)loadQuestions
{
    NSArray *tabcontrollers =  self.tabBarController.viewControllers;
    ProfileViewController *profile = [tabcontrollers objectAtIndex:0];
    //NSLog(@"Questions = %@",[profile profiledata]);
    NSArray * quiz = [[profile profiledata]objectForKey:@"quiz"];
    
    if(question_num < [quiz count])
    {
    [questionText setText:[[quiz objectAtIndex:question_num]objectForKey:@"question"]];
    
    NSMutableDictionary *answers = [[quiz objectAtIndex:question_num]objectForKey:@"answers"];
    
    NSLog(@"%@",answers);
    NSLog(@"Current Image URL=%@",[[answers objectForKey:@"1"]objectForKey:@"url"]);
    
    
    NSData *ImagenUrl = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[answers objectForKey:@"1"]objectForKey:@"url"]]];
    
    [option1Button setImage:[UIImage imageWithData:ImagenUrl] forState:UIControlStateNormal];
    
    [option1Song setText:[[answers objectForKey:@"1"]objectForKey:@"track"]];
    [option1artist setText:[[answers objectForKey:@"1"]objectForKey:@"artist"]];
    
    
    ImagenUrl = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[answers objectForKey:@"2"]objectForKey:@"url"]]];
    
    [option2Button setImage:[UIImage imageWithData:ImagenUrl] forState:UIControlStateNormal];
    
    [option2Song setText:[[answers objectForKey:@"2"]objectForKey:@"track"]];
    [option2artist setText:[[answers objectForKey:@"2"]objectForKey:@"artist"]];
    
    ImagenUrl = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[answers objectForKey:@"3"]objectForKey:@"url"]]];
    
    [option3Button setImage:[UIImage imageWithData:ImagenUrl] forState:UIControlStateNormal];
    
    [option3Song setText:[[answers objectForKey:@"3"]objectForKey:@"track"]];
    [option3artist setText:[[answers objectForKey:@"3"]objectForKey:@"artist"]];
    
    ImagenUrl = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[answers objectForKey:@"4"]objectForKey:@"url"]]];
    
    [option4Button setImage:[UIImage imageWithData:ImagenUrl] forState:UIControlStateNormal];
    
    
    [option4Song setText:[[answers objectForKey:@"4"]objectForKey:@"track"]];
    [option4artist setText:[[answers objectForKey:@"4"]objectForKey:@"artist"]];
    
    current_answer_num = [[[quiz objectAtIndex:question_num]objectForKey:@"correct"]intValue];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"GameOver" message:[NSString stringWithFormat:@"TotalScore: %i",totalscore] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"ShareFacebook", nil];
        UITextField *myTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
        
        [alert addSubview:myTextField];
        [alert show];
    }
    
}

- (void)viewDidUnload
{
    [self setQuestionText:nil];
    [self setOption1Button:nil];
    [self setOption2Button:nil];
    [self setOption3Button:nil];
    [self setOption4Button:nil];
    [self setScoreLabel:nil];
    [self setMultiplierLabel:nil];
    [self setLifeLineButton:nil];
    
    [self setOption1Song:nil];
    [self setOption1artist:nil];
    [self setOption2Song:nil];
    [self setOption2artist:nil];
    [self setOption3Song:nil];
    [self setOption3artist:nil];
    [self setOption4Song:nil];
    [self setOption4artist:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) evaluateanswer {
    /*if(question_num == 1 && clicked_button == 1) {
        totalscore = totalscore + (multiplier * 100);
        multiplier ++;
        
    }
    else if (question_num == 2 && clicked_button == 2) {
        totalscore = totalscore + (multiplier * 100);
        multiplier ++;
    }
    else if (question_num == 3 && clicked_button == 3) {
        totalscore = totalscore + (multiplier * 100);
        multiplier ++;
    }
    else if (question_num == 4 && clicked_button == 4) {
        totalscore = totalscore + (multiplier * 100);
        multiplier ++;
    }*/
    NSString *result;
    if(clicked_button == current_answer_num) {
        totalscore = totalscore + (multiplier * 100);
        multiplier ++;
        result = @"Correct";
    }        
    else {
        multiplier = 1;
        result = @"Wrong";
    }
    
    

    
    [self.navigationItem setTitle:result];
    scoreLabel.text = [NSString stringWithFormat:@"Score : %i",totalscore];
    multiplierLabel.text = [NSString stringWithFormat:@"Multiplier : %i",multiplier];
    
    /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Result", 
                                                    message:result, 
                                                   delegate:self, 
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];*/
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Result" message:result delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.title != @"GameOver")
    {
    question_num ++;
    option1Button.hidden = false;
    option2Button.hidden = false;
    option3Button.hidden = false;
    option4Button.hidden = false;
    
    option1Song.hidden = false;
    option1artist.hidden = false;
    
    option2Song.hidden = false;
    option2artist.hidden = false;

    option3Song.hidden = false;
    option3artist.hidden = false;

    option4Song.hidden = false;
    option4artist.hidden = false;

    
    [self loadQuestions];
    }
    else {
        /*AppDelegate *appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        //[appdelegate facebook]
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //https://graph.facebook.com/me/stereotypesfm:play
        NSString *urlString = @"http://dev.stereotypes.fm/angelhack/mobileauth.php?auth=";
        NSString *urlstr = [NSString stringWithFormat:@"%@%@",urlString,[defaults objectForKey:@"FBAccessTokenKey"]];
        NSURL *url = [NSURL URLWithString:urlstr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSLog(@"%@",urlstr);
        NSString *usertext = [[alertView textFieldAtIndex:0]text];
        void (^successBlock)(NSURLRequest *,NSHTTPURLResponse *,id) = ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            NSLog(@"json = %@",[JSON objectForKey:@"success"]); 
            
        };
        void (^failureBlock)(NSURLRequest *,NSHTTPURLResponse *,NSError *, id) = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"error: %@", error);
        };
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:successBlock failure:failureBlock];
        
        [operation start];*/
        

    }
}


- (IBAction)option1click:(id)sender {
    //question_num ++;
    clicked_button = 1;
    [self evaluateanswer];

}

- (IBAction)option2click:(id)sender {
    //question_num ++;
    clicked_button = 2;
    [self evaluateanswer];
}

- (IBAction)option3click:(id)sender {
    //question_num ++;
    clicked_button = 3;
    [self evaluateanswer];

}

- (IBAction)option4click:(id)sender {
    //question_num ++;
    clicked_button = 4;
    [self evaluateanswer];

}

- (IBAction)lifelineClick:(id)sender {
    /*if(question_num == 1) {
        option2Button.hidden = TRUE;
        option4Button.hidden = TRUE;
    }
    else if (question_num == 2) {
        option1Button.hidden = TRUE;
        option3Button.hidden = TRUE;
    }
    else if (question_num == 3) {
        option1Button.hidden = TRUE;
        option2Button.hidden = TRUE;
    }
    else if (question_num == 4) {
        option1Button.hidden = TRUE;
        option3Button.hidden = TRUE;
    }*/
    if(lifeline_remaining > 0 )
    {
    int remove_two = 2;
    int already_tried = 0;
    while(remove_two > 0)
    {
        int rand_num = rand()%4;
        rand_num ++ ;
        if(rand_num != already_tried && rand_num != current_answer_num) {
            remove_two --;
            already_tried = rand_num;
            if(rand_num == 1) {
                option1Button.hidden = true;
                option1Song.hidden = true;
                option1artist.hidden = true;
            }
            else if(rand_num == 2) {
                option2Button.hidden = true;
                option2Song.hidden = true;
                option2artist.hidden = true;
            }
            else if(rand_num == 3) {
                option3Button.hidden = true;
                option3Song.hidden = true;
                option3artist.hidden = true;
            }
            else if(rand_num == 4) {
                option4Button.hidden = true;
                option4Song.hidden = true;
                option4artist.hidden = true;
            }
        }
    }
    lifeline_remaining--;        
    [lifeLineButton setTitle:[NSString stringWithFormat:@"%i",lifeline_remaining] forState:UIControlStateNormal];
    /*CustomBadge *customBadge1 = [CustomBadge customBadgeWithString:[NSString stringWithFormat:@"LifeLine:%i",lifeline_remaining]
                                                    withStringColor:[UIColor whiteColor] 
                                                        withInsetColor:[UIColor redColor] 
                                                        withBadgeFrame:YES 
                                                   withBadgeFrameColor:[UIColor whiteColor] 
                                                             withScale:1.0
                                                           withShining:YES];
		[customBadge1 setFrame:CGRectMake(10,10,10,10)];
        [lifeLineButton addSubview:customBadge1];
        */

    }
    if(lifeline_remaining == 0) {
        [lifeLineButton setTitle:[NSString stringWithFormat:@"Buy Lifeline",lifeline_remaining] forState:UIControlStateNormal];
    }
}



@end
