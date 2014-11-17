//
//  ViewController.h
//  Roadtrip_IOS
//
//  Created by Krom on 8/14/14.
//  Copyright (c) 2014 SomethingOrOther. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "Reachability.h"

#import "MapFunctions.h"
#import "SystemFunctions.h"

@class ViewController;

@protocol ViewControllerDelegate

-(void)newMapDelegate:(ViewController*)vc;

@end

@interface ViewController : UIViewController<ViewControllerDelegate, GMSMapViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *label_DaysLeft;
@property (strong, nonatomic) IBOutlet UILabel *label_AddressFrom;
@property (strong, nonatomic) IBOutlet UILabel *label_AddressTo;

@property (strong, nonatomic) IBOutlet UIButton *button_Map;
@property (strong, nonatomic) IBOutlet UIButton *button_NearestPOI;
@property (strong, nonatomic) IBOutlet UIButton *button_NewRoute;
@property (strong, nonatomic) IBOutlet UIButton *button_Options;
@property (strong, nonatomic) IBOutlet UIButton *POI_UIButton;

//@property (strong, nonatomic) IBOutlet GMSMapView *gmsMapViewUI;


@property (strong, nonatomic) IBOutlet UILabel *label_PlaceName;
@property (strong, nonatomic) IBOutlet UIImageView *imageview_PlaceIcon;

@property (strong,nonatomic)id delegate;
-(void)getMapDataDelegate;

-(void)testInternetConnection;
-(BOOL)LoadPOI;

-(void)LoadMainMap:(ViewController*)vc;
-(void)SetGMSDefaults;

@end
