//
//  ViewController.m
//  TextFieldTest02
//
//  Created by SDT-1 on 2014. 1. 3..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController {
	int dy;
}

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

- (UITextField *)firstResponderTextField {
	for(id child in self.view.subviews){
		if([child isKindOfClass:[UITextField class]]){
			UITextField *textField = (UITextField *)child;
			if(textField.isFirstResponder) {
				return textField;
			}
		}
	}
	return nil;
}

- (void)keyboardWillShow:(NSNotification *)noti {
	
	UITextField *firstResponder = (UITextField *)[self firstResponderTextField];
	int y = firstResponder.frame.origin.y + firstResponder.frame.size.height+5;
	int viewHeight = self.view.frame.size.height;
	
	NSDictionary *userInfo = [noti userInfo];
	CGRect rect = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
	int keyboardHeight = (int)rect.size.height;
	
	float ani = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
	
	if(keyboardHeight > (viewHeight - y)){
		NSLog(@"키보드가 가림!!");
		[UIView animateWithDuration:ani animations:^{
			dy = keyboardHeight - (viewHeight -y);
			self.view.center = CGPointMake(self.view.center.x, self.view.center.y-dy);
		}];
	} else {
		NSLog(@"키보드가 가리지 않음!");
		dy = 0;
	}
	
}

- (void)keyboardWillHide:(NSNotification *)noti {
	NSLog(@"keyboardWillHide");
	
	if(dy>0) {
		float ani = [[[noti userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
		[UIView animateWithDuration:ani animations:^{
			self.view.center = CGPointMake(self.view.center.x, self.view.center.y + dy);
		}];
	}
}

- (void)viewDidAppear:(BOOL)animated {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end






















