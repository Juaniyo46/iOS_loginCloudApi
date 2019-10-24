//
//  ViewController.h
//  LoginCloud
//
//  Created by Juan Alvarez on 24/10/2019.
//  Copyright © 2019 Juan Alvarez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userText;
@property (weak, nonatomic) IBOutlet UITextField *passText;
- (IBAction)loginBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imagen;

@end

