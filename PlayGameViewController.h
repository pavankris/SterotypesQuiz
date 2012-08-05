//
//  PlayGameViewController.h
//  StereotypeQuiz
//
//  Created by pavan krishnamurthy on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayGameViewController : UIViewController<UIAlertViewDelegate> {
    int totalscore;
    int multiplier;
    int lifeline_remaining;
    int question_num;
    int clicked_button;
    int current_answer_num;
}
@property (weak, nonatomic) IBOutlet UITextView *questionText;
@property (weak, nonatomic) IBOutlet UIButton *option1Button;

@property (weak, nonatomic) IBOutlet UIButton *option2Button;
@property (weak, nonatomic) IBOutlet UIButton *option3Button;
@property (weak, nonatomic) IBOutlet UIButton *option4Button;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *multiplierLabel;
@property (weak, nonatomic) IBOutlet UIButton *lifeLineButton;
- (IBAction)option1click:(id)sender;
- (IBAction)option2click:(id)sender;
- (IBAction)option3click:(id)sender;

- (IBAction)option4click:(id)sender;
- (IBAction)lifelineClick:(id)sender;

-(void)evaluateanswer;


@property (weak, nonatomic) IBOutlet UILabel *option1Song;

@property (weak, nonatomic) IBOutlet UILabel *option1artist;

@property (weak, nonatomic) IBOutlet UILabel *option2Song;

@property (weak, nonatomic) IBOutlet UILabel *option2artist;

@property (weak, nonatomic) IBOutlet UILabel *option3Song;

@property (weak, nonatomic) IBOutlet UILabel *option3artist;

@property (weak, nonatomic) IBOutlet UILabel *option4Song;

@property (weak, nonatomic) IBOutlet UILabel *option4artist;

@end
