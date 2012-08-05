//
//  ViewController.h
//  StereotypeQuiz
//
//  Created by pavan krishnamurthy on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

typedef enum {
    LoginStateStartup,
    LoginStateLoggingIn,
    LoginStateLoggedIn,
    LoginStateLoggedOut
} LoginState;

@interface ViewController : UIViewController<FBSessionDelegate,FBDialogDelegate,FBRequestDelegate> {
    LoginState _loginState;
    NSMutableDictionary *profile_data;
    //FBLoginDialog *_logindialog;
}


@property (weak, nonatomic) IBOutlet UIView *mainview;
- (IBAction)fblogin:(id)sender;
-(void)getUserProfileFromStereotype;
@end
