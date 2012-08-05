//
//  ProfileViewController.h
//  StereotypeQuiz
//
//  Created by pavan krishnamurthy on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController {
    int personal_score;
}

@property(retain) NSMutableDictionary *profiledata; 
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UITextField *profileName;
@property (weak, nonatomic) IBOutlet UILabel *Complexstyp;
@property (weak, nonatomic) IBOutlet UILabel *intensestyp;
@property (weak, nonatomic) IBOutlet UILabel *rhythmicstyp;
@property (weak, nonatomic) IBOutlet UILabel *upbeatstyp;
@property (weak, nonatomic) IBOutlet UILabel *mmtbValLabel;


@end
