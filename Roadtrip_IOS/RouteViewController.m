//
//  RouteViewController.m
//  RoadtripIOS
//
//  Created by Krom on 8/15/14.
//  Copyright (c) 2014 SomethingOrOther. All rights reserved.
//

#import "RouteViewController.h"

@interface RouteViewController () <UITextFieldDelegate>

@end

@implementation RouteViewController

NSString *fromAddress;
NSString *toAddress;

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
    // Do any additional setup after loading the view.
    self.fromTextField.delegate=self;
    self.toTextField.delegate=self;
    self.createRouteButton.enabled=false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [textField setReturnKeyType:UIReturnKeyDone];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(fromAddress!=nil && toAddress!=nil)
        self.createRouteButton.enabled=true;
}

- (IBAction)EnterFromAddress:(id)sender
{
    fromAddress=self.fromTextField.text;
}

- (IBAction)EnterToAddress:(id)sender
{
    toAddress=self.toTextField.text;
}

+(NSString*)GetToAddress
{
    return toAddress;
}

+(NSString*)GetFromAddress
{
    return fromAddress;
}

@end
