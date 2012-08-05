//
//  AppDelegate.h
//  StereotypeQuiz
//
//  Created by pavan krishnamurthy on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    Facebook *_facebook;

}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) Facebook *facebook;
-(BOOL)login:(UIViewController *)delegate;
-(void)logout;

@end
