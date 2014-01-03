//
//  ViewController.m
//  TextFieldTest02
//
//  Created by SDT-1 on 2014. 1. 3..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 205, 50, 50)];
	label.text = @"z입력금지";
//	label.textColor = [UIColor whiteColor];
//	label.backgroundColor = [UIColor clearColor];
	[label sizeToFit];
	[self.view addSubview:label];
	
	UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(130, 200, 171, 31)];
	tf.borderStyle = UITextBorderStyleRoundedRect;
	tf.delegate = self;
	tf.tag = 3;
	
	[self.view addSubview:tf];
	
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	if(3==textField.tag && NSOrderedSame == [string compare:@"z" options:NSCaseInsensitiveSearch])
		return NO;
	return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	if(2==textField.tag)
		return NO;
	return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	NSLog(@"Input : %@", textField.text);
	[textField resignFirstResponder];
	return YES;
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
