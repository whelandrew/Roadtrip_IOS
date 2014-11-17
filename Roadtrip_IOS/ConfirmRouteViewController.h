//
//  ConfirmRouteViewController.h
//  RoadtripIOS
//
//  Created by Krom on 8/15/14.
//  Copyright (c) 2014 SomethingOrOther. All rights reserved.
//

#import "ViewController.h"
#import "RouteViewController.h"
#import "SystemFunctions.h"

#import <GoogleMaps/GoogleMaps.h>

@interface ConfirmRouteViewController : ViewController

@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *confirmButton;


@property (strong, nonatomic) IBOutlet GMSMapView *confirmMapView;

@end