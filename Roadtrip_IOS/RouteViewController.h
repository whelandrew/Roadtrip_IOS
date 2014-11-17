//
//  RouteViewController.h
//  RoadtripIOS
//
//  Created by Krom on 8/15/14.
//  Copyright (c) 2014 SomethingOrOther. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface RouteViewController : ViewController

@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *createRouteButton;

@property (strong, nonatomic) IBOutlet UITextField *fromTextField;
@property (strong, nonatomic) IBOutlet UITextField *toTextField;


+(NSString*)GetToAddress;
+(NSString*)GetFromAddress;
@end
