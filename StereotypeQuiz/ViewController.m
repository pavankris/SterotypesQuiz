//
//  ViewController.m
//  StereotypeQuiz
//
//  Created by pavan krishnamurthy on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "AFJSONRequestOperation.h"
#import "ProfileViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize mainview=_mainview;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
   
  
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    AppDelegate *appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
     if (![[appdelegate facebook] isSessionValid]) {
          NSLog(@"logout");
     }
     else {
         NSLog(@"login");
     }
}


- (IBAction)fblogin:(id)sender {
    AppDelegate *appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    if (![[appdelegate facebook] isSessionValid]) {
        if([appdelegate login:self]) {
            [self getUserProfileFromStereotype];
        }
        NSLog(@"Logged in ..");

    }
    else {
        [[appdelegate facebook]logout];
        NSLog(@"Logged out ..");
    }
         
    
    //[appdelegate logout];
    /*if (_logindialog == nil) {
        /*self.logindialog = [[FBLoginDialog alloc] initWithAppId:appId requestedPermissions:permissions delegate:self];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        _logindialog = [storyboard instantiateViewControllerWithIdentifier:@"FBLoginDialog"];
        
        [_logindialog initWithAppId:appId requestedPermissions:permissions delegate:self];      
        

        //self.mainview = _logindialog.view;
        
    }
    
    if (_loginState == LoginStateStartup || _loginState == LoginStateLoggedOut) {
        _loginState = LoginStateLoggingIn;
        [_logindialog login];
    } else if (_loginState == LoginStateLoggedIn) {
        _loginState = LoginStateLoggedOut;        
        [_logindialog logout];
    }
    [self presentModalViewController:_logindialog animated:YES];*/
    
        
    
}


- (void)accessTokenFound:(NSString *)apiKey {
    NSLog(@"Access token found: %@", apiKey);
    _loginState = LoginStateLoggedIn;
    [self dismissModalViewControllerAnimated:YES];
    //[self refresh];
}

- (void)displayRequired {
    //[self presentModalViewController:_logindialog animated:YES];
}

- (void)closeTapped {
    [self dismissModalViewControllerAnimated:YES];
    _loginState = LoginStateLoggedOut;        
    //[_logindialog logout];
    //[self refresh];
}

-(void)getUserProfileFromStereotype {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *urlString = @"http://dev.stereotypes.fm/angelhack/mobileauth.php?auth=";
    NSString *urlstr = [NSString stringWithFormat:@"%@%@",urlString,[defaults objectForKey:@"FBAccessTokenKey"]];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSLog(@"%@",urlstr);
    
    void (^successBlock)(NSURLRequest *,NSHTTPURLResponse *,id) = ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"json = %@",[JSON objectForKey:@"success"]); 
        if(profile_data == nil) {
            profile_data = [NSMutableDictionary alloc];
        }
        profile_data = [JSON objectForKey:@"success"];

        [self performSegueWithIdentifier:@"profileplay" sender:self];
    };
    void (^failureBlock)(NSURLRequest *,NSHTTPURLResponse *,NSError *, id) = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"error: %@", error);
    };
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:successBlock failure:failureBlock];
     
     [operation start];
    
    
}

- (void)fbDidLogin {
    NSLog(@"Didloggedin");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    AppDelegate *appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [defaults setObject:[[appdelegate facebook] accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[[appdelegate facebook] expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    [self getUserProfileFromStereotype];
    
    
}

- (void) fbDidLogout {
    // Remove saved authorization information if it exists
    NSLog(@"Didlogout");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]) {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [defaults synchronize];
    }
    
}


- (void)fbDidExtendToken:(NSString*)accessToken
               expiresAt:(NSDate*)expiresAt
{
    NSLog(@"token extended");
    AppDelegate *appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[[appdelegate facebook] accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[[appdelegate facebook] expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    [self getUserProfileFromStereotype];
}

- (void)request:(FBRequest *)request didLoad:(id)result {
    NSLog(@"request loaded");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"profileplay"]) {
        UITabBarController *tabcontroller = [segue destinationViewController];
        NSArray *tabbarcontrollerlist = [tabcontroller viewControllers];
        ProfileViewController *profilecontrol = [tabbarcontrollerlist objectAtIndex:0];
        NSLog(@"profile=%@",profile_data);
        if(!profilecontrol.profiledata)
            profilecontrol.profiledata = [[NSMutableDictionary alloc]initWithDictionary:profile_data];
        else {
            profilecontrol.profiledata = profile_data;

        }
    }
}
@end
